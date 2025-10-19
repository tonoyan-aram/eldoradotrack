import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/treasure_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../widgets/achievement_notification.dart';
import '../l10n/app_localizations.dart';
import 'add_treasure_screen.dart';
import 'treasures_screen.dart';
import 'insights_screen.dart';
import 'achievements_screen.dart';
import 'settings_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> get _screens => [
    TodayScreen(onMenuTap: () => _scaffoldKey.currentState?.openDrawer()),
    const TreasuresScreen(),
    const InsightsScreen(),
    const AchievementsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: _buildDrawer(l10n),
      body: Stack(
        children: [
          IndexedStack(index: _currentIndex, children: _screens),
          // Achievement notifications
          Consumer<TreasureProvider>(
            builder: (context, provider, child) {
              if (provider.newAchievements.isNotEmpty) {
                return AchievementNotification(
                  achievement: provider.newAchievements.first,
                  onDismiss: () {
                    provider.clearNewAchievements();
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.today), label: l10n.today),
          BottomNavigationBarItem(icon: const Icon(Icons.auto_awesome), label: l10n.treasures),
          BottomNavigationBarItem(
            icon: const Icon(Icons.analytics),
            label: l10n.insights,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.emoji_events),
            label: l10n.achievements,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: l10n.settings,
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              heroTag: "today_fab",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddTreasureScreen(),
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildDrawer(AppLocalizations l10n) {
    return Drawer(
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppColors.treasureGradient,
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      size: 32,
                      color: AppColors.onPrimary,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.appName,
                      style: const TextStyle(
                        color: AppColors.onPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.appMotto,
                      style: const TextStyle(
                        color: AppColors.onPrimary,
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Navigation items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  icon: Icons.today,
                  title: l10n.today,
                  subtitle: 'Add daily treasures',
                  onTap: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.auto_awesome,
                  title: l10n.treasures,
                  subtitle: 'View all treasures',
                  onTap: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.analytics,
                  title: l10n.insights,
                  subtitle: 'See your progress',
                  onTap: () {
                    setState(() {
                      _currentIndex = 2;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.emoji_events,
                  title: l10n.achievements,
                  subtitle: 'Unlock rewards & badges',
                  onTap: () {
                    setState(() {
                      _currentIndex = 3;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.settings,
                  title: l10n.settings,
                  subtitle: 'App preferences',
                  onTap: () {
                    setState(() {
                      _currentIndex = 4;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                const Divider(),
                _buildDrawerItem(
                  icon: Icons.info,
                  title: l10n.about,
                  subtitle: 'Learn more about app',
                  onTap: () {
                    Navigator.of(context).pop();
                    _showAboutDialog();
                  },
                ),
              ],
            ),
          ),

          // Footer
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Divider(),
                Text(
                  'Version ${AppConstants.appVersion}',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: AppConstants.appName,
      applicationVersion: AppConstants.appVersion,
      applicationIcon: const Icon(
        Icons.auto_awesome,
        size: 48,
        color: AppColors.primary,
      ),
      children: [
        const Text(
          'El Dorado Track helps you discover and track your daily treasures. '
          'Build a collection of meaningful moments and watch your wealth grow!',
        ),
      ],
    );
  }
}

class TodayScreen extends StatelessWidget {
  final VoidCallback? onMenuTap;
  
  const TodayScreen({super.key, this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.today),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: onMenuTap,
          ),
        ),
      ),
      body: Consumer<TreasureProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            );
          }

          final todayEntries = provider.getTodayEntries();
          final hasEntryToday = provider.hasEntryForToday();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  l10n.whatTreasuresDidYouFind,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _getFormattedDate(context),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),

                // Today's entries or empty state
                if (hasEntryToday) ...[
                  Text(
                    l10n.todaysTreasures,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  ...todayEntries
                      .map(
                        (entry) => Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.text,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                if (entry.types.isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 4,
                                    runSpacing: 4,
                                    children: entry.types.map((type) {
                                      final typeColor = AppColors.treasureColors[type.name] ?? AppColors.primary;
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: typeColor.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: typeColor.withOpacity(0.3),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              type.emoji,
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              type.displayName,
                                              style: TextStyle(
                                                color: typeColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 16,
                                      color: AppColors.primary,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Value: ${entry.value}',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ] else ...[
                  // Empty state
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          Icon(
                            Icons.auto_awesome_outlined,
                            size: 80,
                            color: AppColors.primary,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            l10n.emptyTreasureChest,
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            l10n.addTreasureDescription,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: AppColors.textSecondary),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const AddTreasureScreen(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.add),
                              label: Text(l10n.addYourFirstTreasure),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 24),

                // Quick stats
                if (provider.totalEntries > 0) ...[
                  Text(
                    l10n.yourProgress,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          l10n.totalTreasures,
                          '${provider.totalTreasures}',
                          Icons.auto_awesome,
                          AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          l10n.currentLevel,
                          '${provider.currentLevel}',
                          Icons.trending_up,
                          AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          l10n.currentStreak,
                          '${provider.currentStreak} ${l10n.days}',
                          Icons.local_fire_department,
                          AppColors.warning,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'Next Level',
                          '${provider.getTreasuresNeededForNextLevel()}',
                          Icons.star,
                          AppColors.info,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _getFormattedDate(BuildContext context) {
    final now = DateTime.now();
    final l10n = AppLocalizations.of(context);
    return '${now.day} ${l10n.getMonthName(now.month)} ${now.year}';
  }
}

