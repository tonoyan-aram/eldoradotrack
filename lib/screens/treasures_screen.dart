import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/treasure_provider.dart';
import '../models/treasure_entry.dart';
import '../constants/app_colors.dart';
import '../l10n/app_localizations.dart';
import '../widgets/candy_scaffold.dart';
import 'add_treasure_screen.dart';

class TreasuresScreen extends StatefulWidget {
  const TreasuresScreen({super.key});

  @override
  State<TreasuresScreen> createState() => _TreasuresScreenState();
}

class _TreasuresScreenState extends State<TreasuresScreen> {
  TreasureType? _selectedFilter;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return CandyScaffold(
      appBar: AppBar(
        title: Text(l10n.treasures),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showSearchDialog,
          ),
          PopupMenuButton<TreasureType?>(
            icon: const Icon(Icons.filter_list),
            onSelected: (type) {
              setState(() {
                _selectedFilter = type;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem<TreasureType?>(
                value: null,
                child: Text('All Types'),
              ),
              ...TreasureType.values.map(
                (type) => PopupMenuItem<TreasureType?>(
                  value: type,
                  child: Row(
                    children: [
                      Text(type.emoji),
                      const SizedBox(width: 8),
                      Text(type.displayName),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
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

          final filteredEntries = _getFilteredEntries(provider.entries);

          if (filteredEntries.isEmpty) {
            return _buildEmptyState(l10n);
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredEntries.length,
            itemBuilder: (context, index) {
              final entry = filteredEntries[index];
              return _buildTreasureCard(entry, l10n);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddTreasureScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      extendBody: true,
    );
  }

  List<TreasureEntry> _getFilteredEntries(List<TreasureEntry> entries) {
    var filtered = entries;

    // Filter by type
    if (_selectedFilter != null) {
      filtered = filtered
          .where((entry) => entry.types.contains(_selectedFilter!))
          .toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (entry) =>
                entry.text.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }

    return filtered;
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_awesome_outlined,
              size: 80,
              color: AppColors.primary,
            ),
            const SizedBox(height: 24),
            Text(
              _selectedFilter != null
                  ? 'No ${_selectedFilter!.displayName.toLowerCase()} treasures found'
                  : 'No treasures found',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _searchQuery.isNotEmpty
                  ? 'Try adjusting your search terms'
                  : 'Start adding treasures to build your collection!',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddTreasureScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: Text(l10n.addNewTreasure),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTreasureCard(TreasureEntry entry, AppLocalizations l10n) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddTreasureScreen(existingEntry: entry),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with date and value
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDate(entry.createdAt),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(
                        '${entry.value}',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Description
              Text(
                entry.text,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              if (entry.types.isNotEmpty) ...[
                const SizedBox(height: 12),

                // Treasure types
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: entry.types.map((type) {
                    final typeColor =
                        AppColors.treasureColors[type.name] ??
                        AppColors.primary;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: typeColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: typeColor.withOpacity(0.3)),
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
            ],
          ),
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
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  Future<void> _showSearchDialog() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Treasures'),
        content: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Enter search terms...',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _searchQuery = '';
              });
              Navigator.of(context).pop();
            },
            child: const Text('Clear'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
