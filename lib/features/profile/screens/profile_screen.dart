import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/eoi_button.dart';

class ProfileScreen extends StatelessWidget {
  final String profileId;
  const ProfileScreen({super.key, required this.profileId});

  @override
  Widget build(BuildContext context) {
    final bool isOwnProfile = profileId == 'me';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: AppColors.primaryLight,
                    child: const Center(
                      child: Icon(Icons.person, size: 120, color: AppColors.primary),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              if (!isOwnProfile) ...[
                IconButton(icon: const Icon(Icons.block_outlined), onPressed: () {}),
                IconButton(icon: const Icon(Icons.flag_outlined), onPressed: () {}),
              ],
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ayesha Khan, 25',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const SizedBox(height: 4),
                            const Row(
                              children: [
                                Icon(Icons.location_on_outlined, size: 14, color: AppColors.textSecondary),
                                SizedBox(width: 4),
                                Text('Lahore, Pakistan', style: TextStyle(color: AppColors.textSecondary)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (isOwnProfile)
                        const Icon(Icons.verified, color: AppColors.accent, size: 28),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildInfoChip('Sunni', Icons.mosque_outlined),
                      const SizedBox(width: 8),
                      _buildInfoChip('Jutt', Icons.people_outline),
                      const SizedBox(width: 8),
                      _buildInfoChip('5\'5"', Icons.straighten),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('About Me', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  const Text(
                    'Assalamu Alaikum! I am a practicing Muslimah looking for a righteous spouse. '
                    'I value deen, family, and good character above all else. I work as a software engineer '
                    'and am passionate about my career while maintaining my Islamic values.',
                    style: TextStyle(fontSize: 14, height: 1.5, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 24),
                  const Text('Looking For', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  const Text(
                    'A practicing Muslim man with good character, stable career, and family values. '
                    'Sect: Sunni preferred. Location: Lahore or willing to relocate.',
                    style: TextStyle(fontSize: 14, height: 1.5, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 24),
                  const Text('Basic Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  _buildInfoRow('Marital Status', 'Never Married'),
                  _buildInfoRow('Education', 'BS Computer Science'),
                  _buildInfoRow('Occupation', 'Software Engineer'),
                  _buildInfoRow('Prayer', '5 times daily'),
                  _buildInfoRow('Hijab', 'Wears hijab'),
                  const SizedBox(height: 32),
                  if (!isOwnProfile)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_outline),
                        label: const Text('Send Interest'),
                      ),
                    ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
