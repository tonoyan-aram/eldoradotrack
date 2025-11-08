import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_assets.dart';
import '../constants/app_constants.dart';
import '../widgets/candy_background.dart';
import 'main_navigation_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();

  static Future<bool> shouldShowOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    if (AppConstants.debugForceOnboarding) {
      return true;
    }
    final completed =
        prefs.getBool(AppConstants.keyOnboardingCompleted) ?? false;
    final firstLaunch = prefs.getBool(AppConstants.keyFirstLaunch) ?? true;
    return !completed || firstLaunch;
  }
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Welcome to the Candy Kingdom',
      description:
          'Discover daily delights and track every sweet moment worth remembering.',
      asset: AppAssets.chefAlligator,
      color: const Color(0xFFEC407A),
    ),
    OnboardingPage(
      title: 'Collect Sugary Treasures',
      description:
          'Fill your vault with sparkling gems, gummy bears, and rainbow treats.',
      asset: AppAssets.donut,
      color: const Color(0xFFAB47BC),
    ),
    OnboardingPage(
      title: 'Level Up with Sweet Achievements',
      description:
          'Earn rewards as you build your candy collection and share the joy.',
      asset: AppAssets.heart,
      color: const Color(0xFFFF7043),
    ),
    OnboardingPage(
      title: 'Start Your Sugary Adventure',
      description:
          'Jump into a world where every tap brings you closer to candy paradise.',
      asset: AppAssets.gemBlue,
      color: const Color(0xFF29B6F6),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: AppConstants.mediumAnimation,
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skipOnboarding() {
    _completeOnboarding();
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyFirstLaunch, false);
    await prefs.setBool(AppConstants.keyOnboardingCompleted, true);

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CandyBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: _skipOnboarding,
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Color(0xFF7B1FA2),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _buildPage(_pages[index]);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (index) => _buildPageIndicator(index),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentPage > 0)
                      TextButton(
                        onPressed: () {
                          _pageController.previousPage(
                            duration: AppConstants.mediumAnimation,
                            curve: Curves.easeInOut,
                          );
                        },
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            color: Color(0xFF7B1FA2),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    else
                      const SizedBox(width: 60),
                    ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEC407A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppConstants.borderRadius,
                          ),
                        ),
                        shadowColor:
                            Colors.pinkAccent.withValues(alpha: 0.4),
                        elevation: 6,
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1
                            ? 'Get Started'
                            : 'Next',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              color: page.color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: page.color.withValues(alpha: 0.25),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: page.asset != null
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(page.asset!, fit: BoxFit.contain),
                  )
                : Icon(page.icon, size: 60, color: page.color),
          ),

          const SizedBox(height: 48),

          // Title
          Text(
            page.title,
            style:
                Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: const Color(0xFF4A148C),
                  fontWeight: FontWeight.w800,
                ) ??
                const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF4A148C),
                ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),

          // Description
          Text(
            page.description,
            style:
                Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF7B1FA2),
                  height: 1.5,
                ) ??
                const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xFF7B1FA2),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int index) {
    return AnimatedContainer(
      duration: AppConstants.shortAnimation,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _currentPage == index ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? const Color(0xFFEC407A)
            : const Color(0xFF7B1FA2).withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final IconData? icon;
  final Color color;
  final String? asset;

  const OnboardingPage({
    required this.title,
    required this.description,
    required this.color,
    this.icon,
    this.asset,
  });
}
