import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../models/influencer_model.dart';
import 'platform_summary_card.dart';
import 'content_categories_chart.dart';
import '../youtube/brands_section.dart';

/// Profile Summary Tab - Shows overview of all platforms, content categories, and brands
class ProfileSummaryTab extends StatelessWidget {
  final InfluencerModel influencer;

  const ProfileSummaryTab({super.key, required this.influencer});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const ValueKey('profile_summary'),
      primary: false,
      padding: const EdgeInsets.only(bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.lg),

          // Platform Summaries Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              children: influencer.platforms
                  .map((platform) => PlatformSummaryCard(platform: platform))
                  .toList(),
            ),
          ),

          // Content Categories Section
          if (influencer.contentCategories.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: ContentCategoriesChart(
                categories: influencer.contentCategories,
              ),
            ),
          ],

          // Brands Section
          if (influencer.brandCollaborations.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: BrandsSection(brands: influencer.brandCollaborations),
            ),
          ],

          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}
