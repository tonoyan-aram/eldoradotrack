import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_assets.dart';
import '../constants/app_constants.dart';
import '../widgets/candy_background.dart';
import 'main_navigation_screen.dart';
import 'onboarding_screen.dart';
import 'webview_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAppStatus();
  }

  Future<void> _checkAppStatus() async {
    final startTime = DateTime.now();
    developer.log('🔄 Starting app status check...', name: 'SplashScreen');

    try {
      developer.log(
        '📞 Making API request to 173.212.197.75:4048/inka-max/get-accepted...',
        name: 'SplashScreen',
      );

      final response = await http
          .get(
            Uri.parse('http://173.212.197.75:4048/inka-max/get-accepted'),
            headers: const {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      developer.log(
        '📊 API response received: status=${response.statusCode}',
        name: 'SplashScreen',
      );

      bool isPublished = false;
      String webViewUrl = '';

      if (response.statusCode == 200) {
        try {
          final data = json.decode(response.body) as Map<String, dynamic>;
          isPublished = data['published'] as bool? ?? false;
          webViewUrl = data['link'] as String? ?? '';
          developer.log(
            '✅ App status: published=$isPublished, link=$webViewUrl',
            name: 'SplashScreen',
          );
        } catch (error, stackTrace) {
          developer.log(
            '⚠️ Failed to parse response: $error',
            name: 'SplashScreen',
            error: error,
            stackTrace: stackTrace,
          );
        }
      } else {
        developer.log(
          '⚠️ API request failed with status: ${response.statusCode}',
          name: 'SplashScreen',
        );
      }

      final elapsed = DateTime.now().difference(startTime);
      final remainingTime = const Duration(seconds: 3) - elapsed;

      if (remainingTime.inMilliseconds > 0) {
        developer.log(
          '⏳ Waiting ${remainingTime.inMilliseconds}ms for minimum delay...',
          name: 'SplashScreen',
        );
        await Future.delayed(remainingTime);
      }

      if (!mounted) {
        return;
      }

      if (isPublished &&
          webViewUrl.isNotEmpty &&
          !AppConstants.debugForceOnboarding) {
        developer.log(
          '🌐 App is published, navigating to WebView with URL: $webViewUrl',
          name: 'SplashScreen',
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => WebViewScreen(url: webViewUrl),
          ),
        );
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      if (!mounted) {
        return;
      }
      final completed =
          prefs.getBool(AppConstants.keyOnboardingCompleted) ?? false;

      if (AppConstants.debugForceOnboarding || !completed) {
        developer.log(
          '🧭 Onboarding not completed, navigating to OnboardingScreen',
          name: 'SplashScreen',
        );
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      } else {
        developer.log(
          '🎮 App is not published, onboarding completed, navigating to MainNavigationScreen',
          name: 'SplashScreen',
        );
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
        );
      }
    } catch (error, stackTrace) {
      developer.log(
        '❌ Error during app status check: $error',
        name: 'SplashScreen',
        error: error,
        stackTrace: stackTrace,
      );

      final elapsed = DateTime.now().difference(startTime);
      final remainingTime = const Duration(seconds: 3) - elapsed;

      if (remainingTime.inMilliseconds > 0) {
        developer.log(
          '⏳ Waiting ${remainingTime.inMilliseconds}ms for minimum delay after error...',
          name: 'SplashScreen',
        );
        await Future.delayed(remainingTime);
      }

      if (!mounted) {
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      if (!mounted) {
        return;
      }
      final completed =
          prefs.getBool(AppConstants.keyOnboardingCompleted) ?? false;
      if (AppConstants.debugForceOnboarding || !completed) {
        developer.log(
          '🧭 Error occurred, navigating to OnboardingScreen (fallback)',
          name: 'SplashScreen',
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      } else {
        developer.log(
          '🎮 Error occurred, onboarding completed, navigating to MainNavigationScreen (fallback)',
          name: 'SplashScreen',
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CandyBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.75,
                      child: Image.asset(
                        AppAssets.splashBackground,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  AppConstants.appName,
                  textAlign: TextAlign.center,
                  style:
                      theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFFEC407A),
                      ) ??
                      const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFEC407A),
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppConstants.appMotto,
                  textAlign: TextAlign.center,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFF8E24AA),
                        fontStyle: FontStyle.italic,
                      ) ??
                      const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF8E24AA),
                        fontStyle: FontStyle.italic,
                      ),
                ),
                const SizedBox(height: 28),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEC407A)),
                  strokeWidth: 4,
                ),
                const SizedBox(height: 16),
                Text(
                  'Loading...',
                  style:
                      theme.textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF7B1FA2),
                        fontWeight: FontWeight.w600,
                      ) ??
                      const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF7B1FA2),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
