import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/providers/auth_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primaryLight,
                child: const Icon(Icons.person, color: AppColors.primary),
              ),
              title: const Text('Zara Ahmed'),
              subtitle: const Text('zara@example.com'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/profile/me'),
            ),
          ),
          const SizedBox(height: 16),
          _buildSection('Account', [
            _buildTile(Icons.person_outline, 'Edit Profile', () => context.push('/edit-profile')),
            _buildTile(Icons.verified_outlined, 'Verification', null),
            _buildTile(Icons.lock_outline, 'Privacy', null),
            _buildTile(Icons.notifications_outlined, 'Notifications', null),
            _buildTile(Icons.language, 'Language', null),
          ]),
          const SizedBox(height: 16),
          _buildSection('Subscription', [
            _buildTile(Icons.star_outline, 'Premium Plan', () => context.push('/premium')),
            _buildTile(Icons.payment_outlined, 'Payment Methods', null),
          ]),
          const SizedBox(height: 16),
          _buildSection('Support', [
            _buildTile(Icons.help_outline, 'Help & Support', null),
            _buildTile(Icons.description_outlined, 'Terms of Service', null),
            _buildTile(Icons.privacy_tip_outlined, 'Privacy Policy', null),
          ]),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.logout, color: AppColors.error),
              title: const Text('Logout', style: TextStyle(color: AppColors.error)),
              onTap: () {
                ref.read(authProvider.notifier).logout();
                context.go('/welcome');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> tiles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
        ),
        Card(child: Column(children: tiles)),
      ],
    );
  }

  Widget _buildTile(IconData icon, String title, VoidCallback? onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      trailing: const Icon(Icons.chevron_right, size: 20, color: AppColors.textSecondary),
      onTap: onTap,
      dense: true,
    );
  }
}
