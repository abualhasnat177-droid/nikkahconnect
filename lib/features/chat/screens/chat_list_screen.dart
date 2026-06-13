import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/empty_state.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildChatItem(context,
            name: 'Ayesha Khan',
            lastMessage: 'Walaikum Assalam! Yes, that would be nice.',
            time: '5m ago',
            isUnread: true,
            online: true,
          ),
          _buildChatItem(context,
            name: 'Fatima Ali',
            lastMessage: 'I will ask my parents and let you know.',
            time: '2h ago',
            online: false,
          ),
          _buildChatItem(context,
            name: 'Hira Ahmed',
            lastMessage: 'Thank you for reaching out. I am interested.',
            time: '1d ago',
            online: true,
          ),
        ],
      ),
    );
  }

  Widget _buildChatItem(BuildContext context, {
    required String name,
    required String lastMessage,
    required String time,
    bool isUnread = false,
    bool online = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: () => context.push('/chat/1'),
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.primaryLight,
              child: Text(name[0], style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 18)),
            ),
            if (online)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 2)),
                  ),
                ),
              ),
          ],
        ),
        title: Text(name, style: TextStyle(fontWeight: isUnread ? FontWeight.w700 : FontWeight.w500)),
        subtitle: Text(
          lastMessage,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: isUnread ? AppColors.textPrimary : AppColors.textSecondary),
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(time, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
            if (isUnread) ...[
              const SizedBox(height: 4),
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                child: const Center(child: Text('1', style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600))),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
