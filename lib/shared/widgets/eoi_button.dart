import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class EOIButton extends StatelessWidget {
  final bool isSent;
  final bool isLoading;
  final VoidCallback? onTap;

  const EOIButton({
    super.key,
    this.isSent = false,
    this.isLoading = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isSent) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: AppColors.primary, size: 16),
            const SizedBox(width: 6),
            Text(
              'Interest Sent',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      );
    }

    return ElevatedButton.icon(
      onPressed: isLoading ? null : onTap,
      icon: isLoading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            )
          : const Icon(Icons.favorite_outline, size: 18),
      label: Text(isLoading ? 'Sending...' : 'Send Interest'),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(140, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
