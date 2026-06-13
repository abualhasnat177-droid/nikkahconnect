import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/app_theme.dart';

class ProfileCard extends StatelessWidget {
  final String displayName;
  final int age;
  final String? city;
  final String? occupation;
  final String? sectName;
  final String? casteName;
  final String? photoUrl;
  final int? matchScore;
  final String? maritalStatus;
  final VoidCallback? onTap;
  final VoidCallback? onSendInterest;
  final bool isPremium;

  const ProfileCard({
    super.key,
    required this.displayName,
    required this.age,
    this.city,
    this.occupation,
    this.sectName,
    this.casteName,
    this.photoUrl,
    this.matchScore,
    this.maritalStatus,
    this.onTap,
    this.onSendInterest,
    this.isPremium = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPhotoSection(),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '$displayName, $age',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isPremium)
                        const Icon(Icons.verified, color: AppColors.accent, size: 20),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (city != null)
                    _buildInfoRow(Icons.location_on_outlined, city!),
                  if (occupation != null)
                    _buildInfoRow(Icons.work_outline, occupation!),
                  if (sectName != null || casteName != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: [
                          if (sectName != null)
                            Chip(label: Text(sectName!, style: const TextStyle(fontSize: 11))),
                          if (casteName != null)
                            Chip(label: Text(casteName!, style: const TextStyle(fontSize: 11))),
                          if (matchScore != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.success.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${matchScore}% match',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoSection() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: photoUrl != null
              ? CachedNetworkImage(
                  imageUrl: photoUrl!,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(height: 180, color: Colors.white),
                  ),
                  errorWidget: (_, __, ___) => _buildPlaceholder(),
                )
              : _buildPlaceholder(),
        ),
        if (maritalStatus != null && maritalStatus != 'never_married')
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                maritalStatus!.replaceAll('_', ' '),
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 180,
      color: AppColors.primaryLight,
      child: Center(
        child: Icon(
          Icons.person_outline,
          size: 64,
          color: AppColors.primary.withOpacity(0.4),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
