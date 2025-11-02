import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qoruz_flutter_sourav/widgets/youtube/ratio_metric_card.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';
import '../../models/social_platform.dart';

/// Engagement and Views Section - Separate stats for Videos and Shorts
class EngagementViewsSection extends StatelessWidget {
  final PlatformStats platform;

  const EngagementViewsSection({super.key, required this.platform});

  @override
  Widget build(BuildContext context) {
    return Stack(
      // crossAxisAlignment: CrossAxisAlignment.start,
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
                    'ENGAGEMENTS AND VIEWS',
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
                  // Videos Column
                  Expanded(
                    child: _ContentTypeColumn(
                      iconPath: 'assests/svg/youtube_outlined.svg',
                      label: 'Videos',
                      stats: [
                        _StatItem(
                          label: 'AVG. VIEWS',
                          value:
                              platform.formattedAvgViewsVideos ??
                              platform.formattedAvgViews,
                        ),
                        _StatItem(
                          label: 'AVG. VIEWS (7 DAYS)',
                          value: platform.formattedAvgViews7Days ?? 'N/A',
                        ),
                        _StatItem(
                          label: 'AVG. LIKES',
                          value:
                              platform.formattedAvgLikesVideos ??
                              platform.formattedAvgLikes ??
                              'N/A',
                        ),
                        _StatItem(
                          label: 'AVG. COMMENTS',
                          value:
                              platform.formattedAvgCommentsVideos ??
                              platform.formattedAvgComments ??
                              'N/A',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xl),
                  // Shorts Column
                  Expanded(
                    child: _ContentTypeColumn(
                      iconPath: 'assests/svg/youtube_shorts.svg',
                      label: 'Shorts',
                      stats: [
                        _StatItem(
                          label: 'AVG. VIEWS',
                          value: platform.formattedAvgViewsShorts ?? 'N/A',
                        ),
                        _StatItem(
                          label: 'AVG. LIKES',
                          value: platform.formattedAvgLikesShorts ?? 'N/A',
                        ),
                        _StatItem(
                          label: 'AVG. COMMENTS',
                          value: platform.formattedAvgCommentsShorts ?? 'N/A',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),

              const SizedBox(height: AppSpacing.md),
              RatioMetricCard(
                title: 'LIKES - COMMENTS RATIO',
                value: platform.formattedLikesCommentsRatio ?? 'N/A',
                label: platform.likesCommentsRatioLabel ?? 'N/A',
                subtitle:
                    'Average ratio for similar influencers is around 9.21.',
                tooltipMessage:
                    'The ratio of likes to comments on average posts',
              ),
              const SizedBox(height: AppSpacing.lg),
              Divider(),
              const SizedBox(height: AppSpacing.lg),
              RatioMetricCard(
                title: 'RECURRING VIEWERSHIP',
                value: platform.formattedRecurringViewership ?? 'N/A',
                label: platform.recurringViewershipLabel ?? 'N/A',
                subtitle:
                    'Similar accounts generate around 1.57 views per 100 subscribers.',
                tooltipMessage:
                    'How many views are generated per 100 subscribers',
              ),
            ],
          ),
        ),
      ],
    );
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
            SvgPicture.asset(iconPath, width: 20, height: 20),
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
