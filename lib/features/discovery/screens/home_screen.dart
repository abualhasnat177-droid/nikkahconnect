import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/profile_card.dart';
import '../../../shared/widgets/loading_skeleton.dart';
import '../../../shared/widgets/empty_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nikah Connect'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: _isLoading
            ? const LoadingSkeleton()
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Recommended for You',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          '10 / 10 today',
                          style: TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 380,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: 280,
                          child: ProfileCard(
                            displayName: 'Ayesha',
                            age: 25,
                            city: 'Lahore',
                            occupation: 'Software Engineer',
                            sectName: 'Sunni',
                            casteName: 'Jutt',
                            matchScore: 92,
                            isPremium: true,
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 280,
                          child: ProfileCard(
                            displayName: 'Fatima',
                            age: 23,
                            city: 'Karachi',
                            occupation: 'Doctor',
                            sectName: 'Hanafi',
                            matchScore: 85,
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 280,
                          child: ProfileCard(
                            displayName: 'Hira',
                            age: 27,
                            city: 'Islamabad',
                            occupation: 'Teacher',
                            sectName: 'Sunni',
                            casteName: 'Syed',
                            matchScore: 78,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Quick Filters',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('See All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('Sunni', selected: true),
                        const SizedBox(width: 8),
                        _buildFilterChip('Jutt'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Never Married'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Lahore'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Engineer'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'New Profiles',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) => ProfileCard(
                      displayName: 'User ${index + 1}',
                      age: 24 + index,
                      city: 'City ${index + 1}',
                      sectName: 'Sunni',
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildFilterChip(String label, {bool selected = false}) {
    return FilterChip(
      label: Text(label, style: TextStyle(fontSize: 12, color: selected ? Colors.white : AppColors.primary)),
      selected: selected,
      onSelected: (_) {},
      selectedColor: AppColors.primary,
      backgroundColor: AppColors.primaryLight,
      checkmarkColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}
