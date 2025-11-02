import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';
import '../../models/social_platform.dart';

/// Instagram Stats Header Widget - Shows Followers, Engagement Rate, Estimated Reach
class InstagramStatsHeader extends StatelessWidget {
  final PlatformStats platform;

  const InstagramStatsHeader({super.key, required this.platform});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _StatCard(
              label: 'FOLLOWERS',
              value: platform.formattedFollowers,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(color: AppColors.border, width: 1),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: _StatCard(
              label: 'ENGAGEMENT RATE',
              value: platform.formattedEngagement,
              badge: _getEngagementBadge(platform.engagementRate),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(color: AppColors.border, width: 1),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: _StatCard(
              label: 'ESTIMATED REACH',
              value: platform.formattedEstimatedReach ?? 'N/A',
            ),
          ),
        ],
      ),
    );
  }

  String? _getEngagementBadge(double engagementRate) {
    if (engagementRate >= 3.0) return 'Excellent';
    if (engagementRate >= 1.0) return 'Good';
    if (engagementRate >= 0.5) return 'Average';
    return 'Low';
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String? badge;

  const _StatCard({required this.label, required this.value, this.badge});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            child: Text(
              label,
              style: AppTextStyles.overline.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: AppTextStyles.h4.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          if (badge != null) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _getBadgeColor(badge!),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                badge!,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getBadgeColor(String badge) {
    switch (badge) {
      case 'Excellent':
        return const Color(0xFF10B981); // Green
      case 'Good':
        return const Color(0xFF10B981); // Green
      case 'Average':
        return const Color(0xFFF59E0B); // Orange/Yellow
      case 'Low':
        return const Color(0xFFEF4444); // Red
      default:
        return AppColors.textSecondary;
    }
  }
}
