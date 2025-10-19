import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'constants/app_constants.dart';
import 'constants/app_colors.dart';
import 'models/app_theme.dart';
import 'services/treasure_provider.dart';
import 'services/theme_service.dart';
import 'services/locale_service.dart';
import 'l10n/app_localizations.dart';
import 'screens/onboarding_screen.dart';
import 'screens/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeService().initialize();
  await LocaleService().initialize();
  runApp(const ElDoradoTrackApp());
}

class ElDoradoTrackApp extends StatelessWidget {
  const ElDoradoTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TreasureProvider()..initialize()),
        ChangeNotifierProvider.value(value: LocaleService()),
        StreamProvider.value(
          value: ThemeService().themeStream,
          initialData: ThemeService().currentTheme,
        ),
      ],
      child: Consumer2<AppThemeData, LocaleService>(
        builder: (context, theme, localeService, child) {
          return MaterialApp(
            title: AppConstants.appName,
            theme: ThemeService().toFlutterTheme(),
            locale: localeService.currentLocale,
            supportedLocales: LocaleService.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const AppInitializer(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  bool _isLoading = true;
  bool _shouldShowOnboarding = true;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    final shouldShow = await OnboardingScreen.shouldShowOnboarding();
    setState(() {
      _shouldShowOnboarding = shouldShow;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      );
    }

    return _shouldShowOnboarding
        ? const OnboardingScreen()
        : const MainNavigationScreen();
  }
}