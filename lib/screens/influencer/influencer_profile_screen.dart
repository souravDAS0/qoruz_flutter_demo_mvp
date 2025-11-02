import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';
import '../../models/influencer_model.dart';
import '../../models/social_platform.dart';
import '../../providers/influencer_provider.dart';
import '../../widgets/youtube/youtube_stats_header.dart';
import '../../widgets/youtube/qoruz_score_section.dart';
import '../../widgets/youtube/engagement_views_section.dart';
import '../../widgets/youtube/content_section.dart';
import '../../widgets/youtube/audience_section.dart';
import '../../widgets/youtube/brands_section.dart';
import '../../widgets/youtube/youtube_channel_link.dart';
import '../../widgets/profile_summary/profile_summary_tab.dart';
import '../../widgets/instagram/instagram_stats_header.dart';
import '../../widgets/instagram/instagram_engagement_section.dart';
import '../../widgets/instagram/instagram_content_section.dart';

/// Influencer profile screen with tabbed platform views
class InfluencerProfileScreen extends StatefulWidget {
  final String influencerId;

  const InfluencerProfileScreen({super.key, required this.influencerId});

  @override
  State<InfluencerProfileScreen> createState() =>
      _InfluencerProfileScreenState();
}

class _InfluencerProfileScreenState extends State<InfluencerProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<NestedScrollViewState> _nestedScrollViewKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    final influencer = context.read<InfluencerProvider>().getInfluencerById(
      widget.influencerId,
    );
    // +1 for Profile Summary tab
    _tabController = TabController(
      length: (influencer?.platforms.length ?? 4) + 1,
      vsync: this,
    );

    // Add listener to reset scroll position when tab changes
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      // Tab animation has completed, reset scroll position
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Get the inner scroll controller from NestedScrollView
        final innerController =
            _nestedScrollViewKey.currentState?.innerController;
        if (innerController != null && innerController.hasClients) {
          // Jump to top instantly (better UX than animating)
          innerController.jumpTo(-1);
        }
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final influencer = context.read<InfluencerProvider>().getInfluencerById(
      widget.influencerId,
    );

    if (influencer == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Influencer not found')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      body: NestedScrollView(
        key: _nestedScrollViewKey,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            // Collapsible Header
            SliverPersistentHeader(
              pinned: true,
              delegate: _CollapsibleHeaderDelegate(
                influencer: influencer,
                onBackPressed: () => Navigator.of(context).pop(),
              ),
            ),
            // Platform Tabs
            SliverPersistentHeader(
              pinned: true,
              delegate: _PlatformTabsDelegate(
                tabController: _tabController,
                platforms: influencer.platforms,
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // Profile Summary tab (first)
            ProfileSummaryTab(influencer: influencer),
            // Platform tabs
            ...influencer.platforms.map(
              (platform) => _buildPlatformView(context, influencer, platform),
            ),
          ],
        ),
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
            OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Call - Coming soon!')),
                );
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(48, 48),
                maximumSize: const Size(48, 48),
                padding: EdgeInsets.zero,
                side: const BorderSide(color: AppColors.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
              ),
              child: const Icon(Icons.call_outlined),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Add to list - Coming soon!')),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Add to list'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryOrange,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformView(
    BuildContext context,
    InfluencerModel influencer,
    PlatformStats platform,
  ) {
    // Use YouTube-specific view for YouTube platform
    if (platform.platform == SocialPlatform.youtube) {
      return _buildYouTubePlatformView(context, influencer, platform);
    }

    // Use Instagram-specific view for Instagram platform
    if (platform.platform == SocialPlatform.instagram) {
      return _buildInstagramPlatformView(context, influencer, platform);
    }

    // Default view for other platforms
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.md),

          // Key Stats Cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              children: [
                Expanded(
                  child: _StatCard(
                    label: 'Followers',
                    value: platform.formattedFollowers,
                    icon: Icons.people,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _StatCard(
                    label: 'Engagement',
                    value: platform.formattedEngagement,
                    icon: Icons.favorite,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _StatCard(
                    label: 'Qoruz Score',
                    value: platform.formattedQoruzScore ?? 'N/A',
                    icon: Icons.star,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Detailed Metrics
          _buildSection('Platform Statistics', _buildDetailedMetrics(platform)),

          // Content Categories
          if (influencer.contentCategories.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xl),
            _buildSection(
              'Content Categories',
              _buildContentCategories(influencer),
            ),
          ],

          // Audience Demographics
          if (influencer.audienceDemographics != null) ...[
            const SizedBox(height: AppSpacing.xl),
            _buildSection(
              'Audience Demographics',
              _buildAudienceDemographics(influencer),
            ),
          ],

          // Brand Collaborations
          const SizedBox(height: AppSpacing.xl),
          _buildSection(
            'Brand Collaborations',
            _buildBrandCollaborations(influencer),
          ),

          // Portfolio
          const SizedBox(height: AppSpacing.xl),
          _buildSection('Recent Work', _buildPortfolio(influencer)),
        ],
      ),
    );
  }

  /// YouTube-specific platform view with detailed analytics
  Widget _buildYouTubePlatformView(
    BuildContext context,
    InfluencerModel influencer,
    PlatformStats platform,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.lg),

          // 1. YouTube Stats Header (Subscribers, Avg Views, Total Videos)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: YouTubeStatsHeader(platform: platform),
          ),
          const SizedBox(height: AppSpacing.xs),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Divider(),
          ),

          // 2. Qoruz Score Section with Insights
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: QoruzScoreSection(platform: platform),
          ),
          const SizedBox(height: AppSpacing.lg),

          // 3. Engagement and Views Section (Videos & Shorts)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: EngagementViewsSection(platform: platform),
          ),
          const SizedBox(height: AppSpacing.lg),

          // 5. Content Section
          if (influencer.videos.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: ContentSection(videos: influencer.videos),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],

          // 6. Audience Section
          if (influencer.audienceDemographics != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: AudienceSection(
                demographics: influencer.audienceDemographics!,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],

          // 7. Brands Section
          if (influencer.brandCollaborations.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: BrandsSection(brands: influencer.brandCollaborations),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],

          // 8. YouTube Channel Link
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: YouTubeChannelLink(
              channelUrl: platform.channelUrl,
              handle: platform.handle ?? '@channel',
            ),
          ),
        ],
      ),
    );
  }

  /// Instagram-specific platform view with detailed analytics
  Widget _buildInstagramPlatformView(
    BuildContext context,
    InfluencerModel influencer,
    PlatformStats platform,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.lg),

          // 1. Instagram Stats Header (Followers, Engagement Rate, Estimated Reach)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: InstagramStatsHeader(platform: platform),
          ),
          const SizedBox(height: AppSpacing.xs),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: const Divider(),
          ),

          // 2. Qoruz Score Section with Insights
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: QoruzScoreSection(platform: platform),
          ),
          const SizedBox(height: AppSpacing.lg),

          // 3. Engagement and Views Section (Images & Reels)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: InstagramEngagementSection(platform: platform),
          ),
          const SizedBox(height: AppSpacing.lg),

          // 4. Content Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: InstagramContentSection(
              hashtags: influencer.hashtags,
              videos: influencer.videos,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // 5. Audience Section
          if (influencer.audienceDemographics != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: AudienceSection(
                demographics: influencer.audienceDemographics!,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],

          // 6. Brands Section
          if (influencer.brandCollaborations.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: BrandsSection(brands: influencer.brandCollaborations),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.h4),
          const SizedBox(height: AppSpacing.md),
          content,
        ],
      ),
    );
  }

  Widget _buildDetailedMetrics(PlatformStats platform) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            if (platform.avgLikes != null)
              _MetricRow(
                label: 'Avg. Likes',
                value: platform.formattedAvgLikes!,
              ),
            if (platform.avgComments != null)
              _MetricRow(
                label: 'Avg. Comments',
                value: platform.formattedAvgComments!,
              ),
            if (platform.avgShares != null)
              _MetricRow(
                label: 'Avg. Shares',
                value: platform.formattedAvgShares!,
              ),
            _MetricRow(label: 'Avg. Views', value: platform.formattedAvgViews),
            if (platform.estimatedReach != null)
              _MetricRow(
                label: 'Est. Reach',
                value: platform.formattedEstimatedReach!,
              ),
            if (platform.totalPosts != null)
              _MetricRow(
                label: 'Total Posts',
                value: platform.totalPosts.toString(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentCategories(InfluencerModel influencer) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: influencer.contentCategories.map((category) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(category.name, style: AppTextStyles.bodyMedium),
                      Text(
                        category.formattedPercentage,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: category.percentage / 100,
                    backgroundColor: AppColors.border,
                    color: AppColors.primaryOrange,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildAudienceDemographics(InfluencerModel influencer) {
    final demo = influencer.audienceDemographics!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gender Distribution',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            ...demo.genderDistribution.entries.map(
              (entry) => _DemoRow(label: entry.key, percentage: entry.value),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Age Distribution',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            ...demo.ageDistribution.entries.map(
              (entry) => _DemoRow(label: entry.key, percentage: entry.value),
            ),
            if (demo.topCountries.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                'Top Countries',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              ...demo.topCountries
                  .take(3)
                  .map(
                    (country) => _DemoRow(
                      label: country.name,
                      percentage: country.percentage,
                    ),
                  ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBrandCollaborations(InfluencerModel influencer) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: influencer.brandCollaborations.map((brand) {
        return Chip(
          label: Text(brand.name),
          backgroundColor: AppColors.backgroundCard,
        );
      }).toList(),
    );
  }

  Widget _buildPortfolio(InfluencerModel influencer) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
      ),
      itemCount: influencer.portfolioImages.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          child: Image.network(
            influencer.portfolioImages[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

/// Custom delegate for collapsible profile header
class _CollapsibleHeaderDelegate extends SliverPersistentHeaderDelegate {
  final InfluencerModel influencer;
  final VoidCallback onBackPressed;

  static const double minHeight = 120.0;
  static const double maxHeight = 200.0; // Increased for better expanded view

  _CollapsibleHeaderDelegate({
    required this.influencer,
    required this.onBackPressed,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  bool shouldRebuild(covariant _CollapsibleHeaderDelegate oldDelegate) {
    return influencer != oldDelegate.influencer;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // Calculate progress: 0.0 (expanded) to 1.0 (collapsed)
    final progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    // Interpolate values
    final imageRadius = lerpDouble(40.0, 18.0, progress)!;
    final collapsibleOpacity = (1.0 - progress).clamp(0.0, 1.0);
    final nameFontSize = lerpDouble(20.0, 16.0, progress)!; // h3 to h4
    final verifiedIconSize = lerpDouble(18.0, 16.0, progress)!;
    final horizontalPadding = lerpDouble(AppSpacing.lg, 12.0, progress)!;
    final topPadding = lerpDouble(16.0, 8.0, progress)!;

    return Container(
      color: AppColors.white,
      child: Stack(
        children: [
          // Main content with SafeArea
          Positioned.fill(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.only(
                  left: horizontalPadding,
                  right: horizontalPadding,
                  top: topPadding,
                  bottom: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 40), // Space for back button
                    // Profile Image - Always visible
                    Hero(
                      tag: 'influencer-${influencer.id}',
                      child: CircleAvatar(
                        radius: imageRadius,
                        backgroundImage: NetworkImage(influencer.profileImage),
                      ),
                    ),
                    SizedBox(width: lerpDouble(AppSpacing.md, 12.0, progress)),
                    // Content column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Name - Always visible
                          Hero(
                            tag: 'influencer-name-${influencer.id}',
                            child: Material(
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      influencer.name,
                                      style: TextStyle(
                                        fontSize: nameFontSize,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textPrimary,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (influencer.isVerified)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Icon(
                                        Icons.verified,
                                        size: verifiedIconSize,
                                        color: AppColors.teal,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          // Collapsible content - fades out
                          if (collapsibleOpacity > 0.9)
                            Opacity(
                              opacity: collapsibleOpacity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 8),
                                  // Address | Category
                                  Row(
                                    children: [
                                      if (influencer.location != null) ...[
                                        _CategoryChip(
                                          label: influencer.location!,
                                          icon: Icons.location_on,
                                          isAddress: true,
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                      Hero(
                                        tag:
                                            'influencer-category-${influencer.id}',
                                        child: Material(
                                          color: Colors.transparent,
                                          child: _CategoryChip(
                                            label:
                                                influencer.category.displayName,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  // Bio
                                  Text(
                                    influencer.bio,
                                    style: AppTextStyles.bodySmall,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
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
            ),
          ),
          // Back button - Always visible, positioned with SafeArea
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: onBackPressed,
                color: AppColors.textPrimary,
                padding: const EdgeInsets.all(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom delegate for platform tabs
class _PlatformTabsDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabController;
  final List<PlatformStats> platforms;

  _PlatformTabsDelegate({required this.tabController, required this.platforms});

  @override
  double get minExtent => 48.0;

  @override
  double get maxExtent => 48.0;

  @override
  bool shouldRebuild(covariant _PlatformTabsDelegate oldDelegate) {
    return tabController != oldDelegate.tabController ||
        platforms != oldDelegate.platforms;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: AppColors.white,
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        labelColor: AppColors.primaryOrange,
        unselectedLabelColor: AppColors.textSecondary,
        indicatorColor: AppColors.primaryOrange,
        indicatorWeight: 3,
        labelStyle: AppTextStyles.bodyMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
        dividerColor: AppColors.border,
        dividerHeight: 1,
        tabs: [
          // Profile Summary tab (first)
          Tab(
            child: Row(
              children: [
                SvgPicture.asset(
                  'assests/svg/profile_summary.svg',
                  width: 18,
                  height: 18,
                ),
                SizedBox(width: 6),
                Text('Profile Summary'),
              ],
            ),
          ),
          // Platform tabs
          ...platforms.map(
            (platform) => Tab(
              child: Row(
                children: [
                  SvgPicture.asset(
                    platform.platform.svgAssetPath,
                    width: 18,
                    height: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(platform.handle ?? platform.platform.displayName),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isAddress;

  const _CategoryChip({required this.label, this.icon, this.isAddress = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isAddress
            ? AppColors.backgroundCard
            : AppColors.primaryOrange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: AppColors.textSecondary),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: isAddress
                  ? AppColors.textSecondary
                  : AppColors.primaryOrange,
              fontWeight: FontWeight.w600,
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
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primaryOrange, size: 24),
            const SizedBox(height: 4),
            Text(
              value,
              style: AppTextStyles.h4.copyWith(
                color: AppColors.primaryOrange,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  final String label;
  final String value;

  const _MetricRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodyMedium),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoRow extends StatelessWidget {
  final String label;
  final double percentage;

  const _DemoRow({required this.label, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodySmall),
          Text(
            '${percentage.toStringAsFixed(1)}%',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
