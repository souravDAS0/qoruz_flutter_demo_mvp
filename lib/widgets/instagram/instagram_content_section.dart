import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';
import '../../models/video_model.dart';

/// Instagram Content Section Widget - Shows hashtags and content grid
class InstagramContentSection extends StatefulWidget {
  final List<String> hashtags;
  final List<Video> videos;

  const InstagramContentSection({
    super.key,
    required this.hashtags,
    required this.videos,
  });

  @override
  State<InstagramContentSection> createState() =>
      _InstagramContentSectionState();
}

class _InstagramContentSectionState extends State<InstagramContentSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.photo_library_outlined,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'CONTENT',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Hashtags Section
              if (widget.hashtags.isNotEmpty) ...[
                Text(
                  'HASHTAGS',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                SizedBox(
                  height: 32,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.hashtags.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          right: index < widget.hashtags.length - 1
                              ? AppSpacing.sm
                              : 0,
                        ),
                        child: Chip(
                          label: Text(widget.hashtags[index]),
                          backgroundColor: const Color(0xFFf1f4f8),
                          side: BorderSide.none,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 0,
                          ),
                          labelStyle: AppTextStyles.caption.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],

              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.photo_library_outlined,
                          size: 20,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          'CONTENT',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            // View All functionality
                          },
                          child: Text(
                            'View All',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primaryOrange,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    if (widget.videos.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.xl,
                          ),
                          child: Text(
                            'No videos available',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ),
                      )
                    else
                      TabBar(
                        controller: _tabController,
                        isScrollable: false,
                        labelColor: AppColors.primaryOrange,
                        unselectedLabelColor: AppColors.textSecondary,
                        indicatorColor: AppColors.primaryOrange,
                        indicatorWeight: 2,
                        labelStyle: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        dividerColor: AppColors.border,
                        dividerHeight: 1,
                        tabs: const [
                          Tab(text: 'Top Posts'),
                          Tab(text: 'Recent Posts'),
                          Tab(text: 'Brand Posts'),
                        ],
                      ),
                    const SizedBox(height: AppSpacing.md),

                    SizedBox(
                      height: 140,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _ContentGrid(videos: widget.videos),
                          _ContentGrid(videos: widget.videos),
                          _ContentGrid(videos: widget.videos),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContentGrid extends StatelessWidget {
  final List<Video> videos;

  const _ContentGrid({required this.videos});

  @override
  Widget build(BuildContext context) {
    if (videos.isEmpty) {
      return Center(
        child: Text(
          'No content available',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
      );
    }

    final displayVideos = videos.take(6).toList();

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: displayVideos.length,
      itemBuilder: (context, index) {
        final video = displayVideos[index];
        return Padding(
          padding: EdgeInsets.only(
            right: index < displayVideos.length - 1 ? AppSpacing.md : 0,
          ),
          child: _PostThumbnail(video: video),
        );
      },
    );
  }
}

class _PostThumbnail extends StatelessWidget {
  final Video video;

  const _PostThumbnail({required this.video});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  child: Image.network(
                    video.thumbnailUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.backgroundCard,
                        child: const Icon(
                          Icons.photo,
                          size: 32,
                          color: AppColors.textTertiary,
                        ),
                      );
                    },
                  ),
                ),
                // Overlay icon for carousel posts
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.photo_library,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.visibility,
                size: 12,
                color: AppColors.textTertiary,
              ),
              const SizedBox(width: 2),
              Flexible(
                child: Text(
                  video.formattedViews,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textTertiary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              const Icon(
                Icons.favorite,
                size: 12,
                color: AppColors.textTertiary,
              ),
              const SizedBox(width: 2),
              Flexible(
                child: Text(
                  video.formattedLikes,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textTertiary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
