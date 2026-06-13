import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class AccountTypeScreen extends StatelessWidget {
  const AccountTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account Type')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            const Text('Who is this profile for?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('Choose the account type that best describes you.', style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 32),
            _buildOption(
              icon: Icons.person,
              title: 'Individual Account',
              subtitle: 'Create your own profile and find your partner directly.',
              onTap: () => context.push('/signup'),
            ),
            const SizedBox(height: 16),
            _buildOption(
              icon: Icons.family_restroom,
              title: 'Wali / Family Account',
              subtitle: 'Create and manage profiles for your children or family members.',
              onTap: () => context.push('/signup'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(20),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.primaryLight,
          child: Icon(icon, color: AppColors.primary, size: 28),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(subtitle, style: const TextStyle(fontSize: 13)),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
