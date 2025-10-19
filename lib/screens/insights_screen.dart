import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/treasure_provider.dart';
import '../constants/app_colors.dart';
import '../l10n/app_localizations.dart';
import '../widgets/level_progress_widget.dart';
import '../widgets/treasure_statistics_card.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.insights),
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

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Level Progress
                LevelProgressWidget(
                  currentLevel: provider.currentLevel,
                  totalTreasures: provider.totalTreasures,
                  treasuresToNextLevel: provider.getTreasuresNeededForNextLevel(),
                  progress: provider.getLevelProgress(),
                ),
                
                const SizedBox(height: 16),
                
                // Statistics Grid
                _buildStatisticsGrid(provider, l10n),
                
                const SizedBox(height: 16),
                
                // Treasure Statistics
                TreasureStatisticsCard(
                  typeStatistics: provider.treasureTypeStatistics,
                  totalTreasures: provider.totalTreasures,
                  totalEntries: provider.totalEntries,
                ),
                
                const SizedBox(height: 16),
                
                // Recent Activity
                _buildRecentActivityCard(context, provider, l10n),
              ],
            ),
          );
        },
      ),
    );
  }


  Widget _buildStatisticsGrid(TreasureProvider provider, AppLocalizations l10n) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard(
          'Total Treasures',
          '${provider.totalTreasures}',
          Icons.auto_awesome,
          AppColors.primary,
        ),
        _buildStatCard(
          'Current Level',
          '${provider.currentLevel}',
          Icons.trending_up,
          AppColors.secondary,
        ),
        _buildStatCard(
          'Current Streak',
          '${provider.currentStreak} days',
          Icons.local_fire_department,
          AppColors.warning,
        ),
        _buildStatCard(
          'Total Entries',
          '${provider.totalEntries}',
          Icons.list,
          AppColors.info,
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
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


  Widget _buildRecentActivityCard(BuildContext context, TreasureProvider provider, AppLocalizations l10n) {
    final recentEntries = provider.entries.take(5).toList();
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            if (recentEntries.isEmpty)
              Text(
                'No recent activity',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              )
            else
              ...recentEntries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      // Date
                      SizedBox(
                        width: 60,
                        child: Text(
                          _formatDate(entry.createdAt),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      
                      // Description
                      Expanded(
                        child: Text(
                          entry.text,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      
                      // Value
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 14,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${entry.value}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else {
      return '${date.day}/${date.month}';
    }
  }
}
