import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';
import '../../models/influencer_model.dart';
import '../../models/social_platform.dart';
import '../../providers/influencer_provider.dart';

/// Influencer profile screen
class InfluencerProfileScreen extends StatelessWidget {
  final String influencerId;

  const InfluencerProfileScreen({super.key, required this.influencerId});

  @override
  Widget build(BuildContext context) {
    final influencer = context
        .read<InfluencerProvider>()
        .getInfluencerById(influencerId);

    if (influencer == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text('Influencer not found'),
        ),
      );
    }

    final primaryPlatform = influencer.primaryPlatform;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Gradient Background
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    // Profile Image
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(influencer.profileImage),
                          backgroundColor: AppColors.white,
                        ),
                        if (influencer.isVerified)
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: AppColors.teal,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.check,
                                size: 20,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      influencer.name,
                      style: AppTextStyles.h2.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.2),
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusSm),
                      ),
                      child: Text(
                        influencer.category.displayName,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: AppColors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Share - Coming soon!')),
                  );
                },
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stats Bar
                Transform.translate(
                  offset: const Offset(0, -30),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusLg),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.textPrimary.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatColumn(
                          label: 'Followers',
                          value: primaryPlatform.formattedFollowers,
                        ),
                        _StatColumn(
                          label: 'Engagement',
                          value: primaryPlatform.formattedEngagement,
                        ),
                        _StatColumn(
                          label: 'Avg Views',
                          value: primaryPlatform.formattedAvgViews,
                        ),
                      ],
                    ),
                  ),
                ),

                // Platform Tabs
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Wrap(
                    spacing: AppSpacing.sm,
                    children: influencer.platforms.map((platform) {
                      return Chip(
                        avatar: Icon(
                          _getPlatformIcon(platform.platform),
                          size: 16,
                        ),
                        label: Text(platform.platform.displayName),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                // About Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('About', style: AppTextStyles.h3),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        influencer.bio,
                        style: AppTextStyles.bodyLarge,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      _InfoRow(
                        icon: Icons.location_on_outlined,
                        text: influencer.location ?? 'Location not specified',
                      ),
                      _InfoRow(
                        icon: Icons.language,
                        text: influencer.languages.join(', '),
                      ),
                      _InfoRow(
                        icon: Icons.calendar_today,
                        text:
                            'Joined ${DateFormat('MMM yyyy').format(influencer.joinedDate)}',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                // Portfolio Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Recent Work', style: AppTextStyles.h3),
                      const SizedBox(height: AppSpacing.md),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: AppSpacing.sm,
                          mainAxisSpacing: AppSpacing.sm,
                        ),
                        itemCount: influencer.portfolioImages.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusSm),
                            child: Image.network(
                              influencer.portfolioImages[index],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                // Brands Worked With
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Brands Worked With', style: AppTextStyles.h3),
                      const SizedBox(height: AppSpacing.md),
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: influencer.brandCollaborations.map((brand) {
                          return Chip(
                            label: Text(brand),
                            backgroundColor: AppColors.backgroundCard,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Message - Coming soon!')),
                  );
                },
                icon: const Icon(Icons.message_outlined),
                label: const Text('Message'),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Start Campaign - Coming soon!')),
                  );
                },
                icon: const Icon(Icons.rocket_launch),
                label: const Text('Start Campaign'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getPlatformIcon(SocialPlatform platform) {
    switch (platform) {
      case SocialPlatform.instagram:
        return Icons.camera_alt;
      case SocialPlatform.youtube:
        return Icons.play_circle_outline;
      case SocialPlatform.tiktok:
        return Icons.music_note;
      case SocialPlatform.twitter:
        return Icons.tag;
    }
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;

  const _StatColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.h3.copyWith(
            color: AppColors.primaryOrange,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: AppTextStyles.bodySmall,
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
