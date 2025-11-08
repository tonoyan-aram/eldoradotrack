import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../l10n/app_localizations.dart';
import '../services/locale_service.dart';
import '../services/theme_service.dart';
import '../services/treasure_provider.dart';
import '../widgets/candy_scaffold.dart';
import 'privacy_policy_screen.dart';
import 'themes_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return CandyScaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Preferences Section
          _buildSectionHeader(context, 'Preferences'),

          // Language
          _buildSettingsTile(
            context,
            icon: Icons.language,
            title: l10n.language,
            subtitle: LocaleService().getLocaleName(
              LocaleService().currentLocale,
            ),
            onTap: () => _showLanguageDialog(context),
          ),

          // Theme
          _buildSettingsTile(
            context,
            icon: Icons.palette,
            title: l10n.theme,
            subtitle: 'Customize appearance',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ThemesScreen()),
              );
            },
          ),

          // Animations
          Consumer<TreasureProvider>(
            builder: (context, provider, child) {
              return _buildSwitchTile(
                icon: Icons.animation,
                title: l10n.animations,
                subtitle: 'Enable/disable animations',
                value: provider.animationsEnabled,
                onChanged: (value) => provider.toggleAnimations(),
              );
            },
          ),

          const SizedBox(height: 24),

          // Data Section
          _buildSectionHeader(context, 'Data'),

          // Export Data
          _buildSettingsTile(
            context,
            icon: Icons.download,
            title: l10n.exportData,
            subtitle: 'Export your treasures',
            onTap: () => _exportData(context),
          ),

          const SizedBox(height: 24),

          // About Section
          _buildSectionHeader(context, 'About'),

          // Privacy Policy
          _buildSettingsTile(
            context,
            icon: Icons.privacy_tip,
            title: 'Privacy Policy',
            subtitle: 'View our privacy policy',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyScreen(),
                ),
              );
            },
          ),

          // About
          _buildSettingsTile(
            context,
            icon: Icons.info,
            title: l10n.about,
            subtitle: 'App information',
            onTap: () => _showAboutDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: SwitchListTile(
        secondary: Icon(icon, color: AppColors.primary),
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Future<void> _showLanguageDialog(BuildContext context) async {
    final localeService = LocaleService();
    final currentLocale = localeService.currentLocale;

    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: LocaleService.supportedLocales.map((locale) {
            return RadioListTile<Locale>(
              title: Row(
                children: [
                  Text(localeService.getLocaleFlag(locale)),
                  const SizedBox(width: 8),
                  Text(localeService.getLocaleName(locale)),
                ],
              ),
              value: locale,
              groupValue: currentLocale,
              onChanged: (value) {
                if (value != null) {
                  localeService.changeLocale(value);
                  Navigator.of(dialogContext).pop();
                }
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _exportData(BuildContext context) async {
    try {
      final provider = Provider.of<TreasureProvider>(context, listen: false);
      await provider.exportEntries();

      // In a real app, you would save this to a file or share it
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data exported successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error exporting data: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'El Dorado Track',
      applicationVersion: '1.0.0',
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
        const SizedBox(height: 16),
        const Text('Features:', style: TextStyle(fontWeight: FontWeight.bold)),
        const Text('• Track daily treasures'),
        const Text('• Level up system'),
        const Text('• Achievement system'),
        const Text('• Multiple themes'),
        const Text('• Data export'),
      ],
    );
  }
}
