import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/profile_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  bool _showFilters = false;

  final _sects = ['Sunni', 'Hanafi', 'Shia', 'Deobandi', 'Barelvi', 'Ahle Hadees'];
  final _castes = ['Jutt', 'Arain', 'Syed', 'Sheikh', 'Pathan', 'Mughal', 'Rajput'];
  final _cities = ['Lahore', 'Karachi', 'Islamabad', 'Rawalpindi', 'Faisalabad', 'Multan'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        actions: [
          IconButton(
            icon: Icon(_showFilters ? Icons.filter_list_off : Icons.filter_list),
            onPressed: () => setState(() => _showFilters = !_showFilters),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name, city, occupation...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          if (_showFilters)
            Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Filters', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  const SizedBox(height: 12),
                  const Text('Age Range', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                  const SizedBox(height: 4),
                  RangeSlider(
                    values: const RangeValues(18, 45),
                    min: 18,
                    max: 70,
                    divisions: 52,
                    labels: RangeLabels('18', '45'),
                    onChanged: (_) {},
                    activeColor: AppColors.primary,
                  ),
                  const SizedBox(height: 12),
                  const Text('Islamic Sect', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: _sects.map((s) => FilterChip(
                      label: Text(s, style: const TextStyle(fontSize: 12)),
                      selected: false,
                      onSelected: (_) {},
                      selectedColor: AppColors.primaryLight,
                      checkmarkColor: AppColors.primary,
                    )).toList(),
                  ),
                  const SizedBox(height: 12),
                  const Text('Caste / Biradari', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: _castes.map((c) => FilterChip(
                      label: Text(c, style: const TextStyle(fontSize: 12)),
                      selected: false,
                      onSelected: (_) {},
                      selectedColor: AppColors.primaryLight,
                      checkmarkColor: AppColors.primary,
                    )).toList(),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => setState(() => _showFilters = false),
                      child: const Text('Apply Filters'),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: _searchController.text.isEmpty
                ? const Center(
                    child: Text('Search for profiles above', style: TextStyle(color: AppColors.textSecondary)),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) => ProfileCard(
                      displayName: 'Result ${index + 1}',
                      age: 25 + index,
                      city: 'Lahore',
                      sectName: 'Sunni',
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
