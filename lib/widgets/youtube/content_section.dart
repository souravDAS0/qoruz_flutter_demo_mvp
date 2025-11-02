import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';
import '../../models/video_model.dart';

/// Content Section Widget - Shows video thumbnails with metrics
class ContentSection extends StatelessWidget {
  final List<Video> videos;

  const ContentSection({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    // Limit to 6 videos
    final displayVideos = videos.take(6).toList();

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
              if (displayVideos.isEmpty)
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
                SizedBox(
                  height: 140,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: displayVideos.length,
                    itemBuilder: (context, index) {
                      final video = displayVideos[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          right: index < displayVideos.length - 1
                              ? AppSpacing.md
                              : 0,
                        ),
                        child: _VideoThumbnail(video: video),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _VideoThumbnail extends StatelessWidget {
  final Video video;

  const _VideoThumbnail({required this.video});

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
                          Icons.play_circle_outline,
                          size: 32,
                          color: AppColors.textTertiary,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.play_arrow,
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
              const Icon(Icons.favorite, size: 12, color: AppColors.textTertiary),
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
