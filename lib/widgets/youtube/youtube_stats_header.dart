import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';
import '../../models/social_platform.dart';

/// YouTube Stats Header Widget - Shows Subscribers, Avg Views, Total Videos
class YouTubeStatsHeader extends StatelessWidget {
  final PlatformStats platform;

  const YouTubeStatsHeader({super.key, required this.platform});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _StatCard(
              label: 'SUBSCRIBERS',
              value:
                  platform.formattedSubscribers ?? platform.formattedFollowers,
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
              label: 'AVG. VIEWS',
              value:
                  platform.formattedAvgViewsVideos ??
                  platform.formattedAvgViews,
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
              label: 'TOTAL VIDEOS',
              value: platform.formattedTotalVideos ?? 'N/A',
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

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
          Text(
            value,
            style: AppTextStyles.h4.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
