import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/social_platform.dart';

/// Platform summary card widget - displays key metrics for a platform
class PlatformSummaryCard extends StatelessWidget {
  final PlatformStats platform;

  const PlatformSummaryCard({super.key, required this.platform});

  /// Get the platform profile URL based on platform type and handle
  String _getPlatformUrl() {
    final handle = platform.handle ?? '';

    switch (platform.platform) {
      case SocialPlatform.youtube:
        // Use channelUrl if available, otherwise construct from handle
        return platform.channelUrl ?? 'https://www.youtube.com/$handle';
      case SocialPlatform.instagram:
        return 'https://www.instagram.com/${handle.replaceAll('@', '')}';
      case SocialPlatform.twitter:
        return platform.channelUrl ??
            'https://x.com/${handle.replaceAll('@', '')}';

      case SocialPlatform.facebook:
        return 'https://www.facebook.com/${handle.replaceAll('@', '')}';
    }
  }

  /// Launch the platform URL
  Future<void> _launchPlatform(BuildContext context) async {
    final url = _getPlatformUrl();
    final Uri uri = Uri.parse(url);

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Could not open profile')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error opening profile: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Platform header with icon and handle
          Row(
            children: [
              SvgPicture.asset(
                platform.platform.svgAssetPath,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: InkWell(
                  focusColor: AppColors.primaryOrange,
                  onTap: () => _launchPlatform(context),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          platform.handle ?? platform.platform.displayName,
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Qoruz Score Badge
              if (platform.qoruzScore != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    // color: AppColors.primaryOrange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assests/png/qoruz_logo_only.png',
                        height: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        platform.formattedQoruzScore ?? 'N/A',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryOrange,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // Metrics Grid
          Row(
            children: [
              // Followers
              Expanded(
                child: _MetricItem(
                  label: platform.platform == SocialPlatform.youtube
                      ? 'Subscribers'
                      : 'Followers',
                  value: platform.formattedFollowers,
                  icon: Icons.people_outline,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              // Avg Views
              Expanded(
                child: _MetricItem(
                  label: 'Avg. Views',
                  value: platform.formattedAvgViews,
                  icon: Icons.visibility_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              // Engagement Rate
              Expanded(
                child: _MetricItem(
                  label: 'Engagement',
                  value: platform.formattedEngagement,
                  icon: Icons.favorite_outline,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              // Placeholder for alignment
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _MetricItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: AppColors.textTertiary),
            const SizedBox(width: 4),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
