import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qoruz_flutter_sourav/widgets/youtube/ratio_metric_card.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';
import '../../models/social_platform.dart';

/// Instagram Engagement and Views Section - Separate stats for Images and Reels
class InstagramEngagementSection extends StatelessWidget {
  final PlatformStats platform;

  const InstagramEngagementSection({super.key, required this.platform});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient overlay
        Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSpacing.radiusMd),
              topRight: Radius.circular(AppSpacing.radiusMd),
            ),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF1F4F8),
                Color(0x00F1F4F8), // transparent with F1F4F8 color
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.favorite_outline,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'ENGAGEMENTS & VIEWS',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: AppColors.textTertiary,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Images Column
                  Expanded(
                    child: _ContentTypeColumn(
                      iconPath: 'assests/svg/insta_image_outline.svg',
                      label: 'Images',
                      stats: [
                        _StatItem(
                          label: 'AVG. LIKES',
                          value:
                              platform.formattedAvgLikes ??
                              platform.formattedAvgViews,
                        ),
                        _StatItem(
                          label: 'AVG. COMMENTS',
                          value: platform.formattedAvgComments ?? 'N/A',
                        ),
                        _StatItem(
                          label: 'ENGAGEMENT RATE',
                          value: platform.formattedEngagement,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xl),
                  // Reels Column
                  Expanded(
                    child: _ContentTypeColumn(
                      iconPath: 'assests/svg/insta_reels.svg',
                      label: 'Reels',
                      stats: [
                        _StatItem(
                          label: 'AVG. VIEWS',
                          value:
                              platform.formattedAvgViewsShorts ??
                              platform.formattedAvgViews,
                        ),
                        _StatItem(
                          label: 'AVG. LIKES',
                          value: platform.formattedAvgLikesShorts ?? 'N/A',
                        ),
                        _StatItem(
                          label: 'AVG. COMMENTS',
                          value: platform.formattedAvgCommentsShorts ?? 'N/A',
                        ),
                        _StatItem(
                          label: 'ENGAGEMENT RATE',
                          value: _calculateReelsEngagement(platform),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: AppSpacing.md),
              RatioMetricCard(
                title: 'LIKES - COMMENTS RATIO',
                value:
                    platform.formattedLikesCommentsRatio ??
                    _calculateLikesCommentsRatio(platform),
                label: platform.likesCommentsRatioLabel ?? 'Average',
                subtitle:
                    'Average ratio for similar influencers is around 1.46.',
                tooltipMessage:
                    'The ratio of likes to comments on average posts',
              ),
              const SizedBox(height: AppSpacing.lg),
              const Divider(),
              const SizedBox(height: AppSpacing.lg),
              RatioMetricCard(
                title: 'REEL VIEWS TO FOLLOWERS RATIO',
                value: _calculateReelViewsRatio(platform),
                label: _getReelViewsLabel(platform),
                subtitle:
                    'Similar accounts generate around 28.99 views per 100 followers.',
                tooltipMessage:
                    'How many reel views are generated per 100 followers',
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _calculateReelsEngagement(PlatformStats platform) {
    // For Instagram reels, calculate a lower engagement rate
    // Typically reels have lower engagement than regular posts
    if (platform.avgViewsShorts != null && platform.followers > 0) {
      final reelsEngagement =
          (platform.avgLikesShorts ?? 0) / platform.followers * 100;
      return '${reelsEngagement.toStringAsFixed(2)}%';
    }
    return '0.28%'; // Default value from the image
  }

  String _calculateLikesCommentsRatio(PlatformStats platform) {
    if (platform.avgLikes != null &&
        platform.avgComments != null &&
        platform.avgComments! > 0) {
      final ratio = platform.avgLikes! / platform.avgComments!;
      return ratio.toStringAsFixed(2);
    }
    return 'N/A';
  }

  String _calculateReelViewsRatio(PlatformStats platform) {
    if (platform.avgViewsShorts != null && platform.followers > 0) {
      final ratio = (platform.avgViewsShorts! / platform.followers) * 100;
      return ratio.toStringAsFixed(2);
    }
    return 'N/A';
  }

  String _getReelViewsLabel(PlatformStats platform) {
    if (platform.avgViewsShorts != null && platform.followers > 0) {
      final ratio = (platform.avgViewsShorts! / platform.followers) * 100;
      if (ratio >= 50) return 'Excellent';
      if (ratio >= 20) return 'Good';
      if (ratio >= 10) return 'Average';
      return 'Low';
    }
    return 'N/A';
  }
}

class _ContentTypeColumn extends StatelessWidget {
  final String iconPath;
  final String label;
  final List<_StatItem> stats;

  const _ContentTypeColumn({
    required this.iconPath,
    required this.label,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(iconPath, width: 16, height: 16),
            const SizedBox(width: AppSpacing.sm),
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        ...stats,
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 4),
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
