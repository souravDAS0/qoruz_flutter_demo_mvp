import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_spacing.dart';
import '../models/influencer_model.dart';
import '../models/social_platform.dart';

/// Reusable influencer card widget
class InfluencerCard extends StatelessWidget {
  final InfluencerModel influencer;
  final VoidCallback onTap;

  const InfluencerCard({
    super.key,
    required this.influencer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primaryPlatform = influencer.primaryPlatform;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Profile Image
              Hero(
                tag: 'influencer-${influencer.id}',
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(influencer.profileImage),
                    ),
                    if (influencer.isVerified)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppColors.teal,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            size: 12,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 6),

              // Name
              Hero(
                tag: 'influencer-name-${influencer.id}',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    influencer.name,
                    style: AppTextStyles.h4.copyWith(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 4),

              // Category Badge
              Hero(
                tag: 'influencer-category-${influencer.id}',
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryOrange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: Text(
                      influencer.category.displayName,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primaryOrange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),

              // Platform Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: influencer.platforms.take(3).map((platform) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: SvgPicture.asset(
                      _getPlatformSvgPath(platform.platform),
                      width: 16,
                      height: 16,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 6),

              // Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: _StatItem(
                      icon: Icons.people_outline,
                      value: primaryPlatform.formattedFollowers,
                    ),
                  ),
                  Flexible(
                    child: _StatItem(
                      icon: Icons.trending_up,
                      value: primaryPlatform.formattedEngagement,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // View Profile Button
              SizedBox(
                width: double.infinity,
                height: 32,
                child: OutlinedButton(
                  onPressed: onTap,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                  ),
                  child: Text(
                    'View Profile',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getPlatformSvgPath(SocialPlatform platform) {
    return platform.svgAssetPath;
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;

  const _StatItem({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textTertiary),
        const SizedBox(width: 4),
        Text(
          value,
          style: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
