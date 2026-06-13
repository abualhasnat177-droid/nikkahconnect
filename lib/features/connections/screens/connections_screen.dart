import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/empty_state.dart';

class ConnectionsScreen extends StatefulWidget {
  const ConnectionsScreen({super.key});

  @override
  State<ConnectionsScreen> createState() => _ConnectionsScreenState();
}

class _ConnectionsScreenState extends State<ConnectionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connections'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Received'),
            Tab(text: 'Sent'),
            Tab(text: 'Matches'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildReceivedTab(),
          _buildSentTab(),
          _buildMatchesTab(),
        ],
      ),
    );
  }

  Widget _buildReceivedTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildConnectionCard(
          name: 'Ayesha Khan',
          age: 25,
          city: 'Lahore',
          isReceived: true,
        ),
        const SizedBox(height: 12),
        _buildConnectionCard(
          name: 'Fatima Ali',
          age: 23,
          city: 'Karachi',
          isReceived: true,
        ),
      ],
    );
  }

  Widget _buildSentTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildConnectionCard(
          name: 'Hira Ahmed',
          age: 27,
          city: 'Islamabad',
          status: 'pending',
        ),
        const SizedBox(height: 12),
        _buildConnectionCard(
          name: 'Zainab Malik',
          age: 26,
          city: 'Rawalpindi',
          status: 'accepted',
        ),
      ],
    );
  }

  Widget _buildMatchesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildMatchCard(name: 'Sana Jutt', age: 24, city: 'Lahore', lastMessage: 'Assalamu Alaikum!'),
        const SizedBox(height: 12),
        _buildMatchCard(name: 'Mariam Sheikh', age: 26, city: 'Karachi'),
      ],
    );
  }

  Widget _buildConnectionCard({
    required String name,
    required int age,
    required String city,
    bool isReceived = false,
    String? status,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.primaryLight,
              child: Text(
                name[0],
                style: const TextStyle(fontSize: 22, color: AppColors.primary, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$name, $age', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  const SizedBox(height: 2),
                  Text(city, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                ],
              ),
            ),
            if (isReceived)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check_circle, color: AppColors.success),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.cancel, color: AppColors.error),
                    onPressed: () {},
                  ),
                ],
              )
            else if (status == 'pending')
              const Chip(
                label: Text('Pending', style: TextStyle(fontSize: 11, color: AppColors.warning)),
                backgroundColor: Color(0xFFFFF3E0),
              )
            else if (status == 'accepted')
              const Chip(
                label: Text('Accepted', style: TextStyle(fontSize: 11, color: AppColors.success)),
                backgroundColor: Color(0xFFE8F5E9),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchCard({
    required String name,
    required int age,
    required String city,
    String? lastMessage,
  }) {
    return Card(
      child: ListTile(
        onTap: () => context.push('/chat/1'),
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryLight,
          child: Text(name[0], style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
        ),
        title: Text('$name, $age'),
        subtitle: Text(lastMessage ?? city, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
