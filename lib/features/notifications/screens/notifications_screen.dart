import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/empty_state.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Mark All Read', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNotification(
            icon: Icons.favorite,
            title: 'New Interest Received',
            body: 'Ayesha Khan sent you an expression of interest.',
            time: '5m ago',
            isUnread: true,
          ),
          _buildNotification(
            icon: Icons.check_circle,
            title: 'Interest Accepted',
            body: 'Fatima Ali accepted your interest request.',
            time: '2h ago',
            isUnread: true,
          ),
          _buildNotification(
            icon: Icons.message,
            title: 'New Message',
            body: 'Hira Ahmed sent you a message.',
            time: '1d ago',
          ),
          _buildNotification(
            icon: Icons.visibility,
            title: 'Profile Viewed',
            body: 'Someone viewed your profile.',
            time: '2d ago',
          ),
          _buildNotification(
            icon: Icons.verified,
            title: 'Verification Approved',
            body: 'Your CNIC verification has been approved.',
            time: '3d ago',
          ),
        ],
      ),
    );
  }

  Widget _buildNotification({
    required IconData icon,
    required String title,
    required String body,
    required String time,
    bool isUnread = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: isUnread ? AppColors.primaryLight.withOpacity(0.3) : Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isUnread ? AppColors.primary : AppColors.primaryLight,
          child: Icon(icon, color: isUnread ? Colors.white : AppColors.primary, size: 20),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: isUnread ? FontWeight.w700 : FontWeight.w500, fontSize: 14),
        ),
        subtitle: Text(body, style: const TextStyle(fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: Text(time, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        onTap: () {},
      ),
    );
  }
}
