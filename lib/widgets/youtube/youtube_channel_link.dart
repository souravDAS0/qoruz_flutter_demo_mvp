import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';

/// YouTube Channel Link Widget - Opens YouTube channel
class YouTubeChannelLink extends StatelessWidget {
  final String? channelUrl;
  final String handle;

  const YouTubeChannelLink({super.key, this.channelUrl, required this.handle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: InkWell(
        onTap: () => _launchYouTubeChannel(context),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.backgroundCard,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.play_circle_outline,
                color: Color(0xFFFF0000), // YouTube Red
                size: 24,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Go to YouTube channel',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              const Icon(
                Icons.arrow_forward,
                color: AppColors.textSecondary,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchYouTubeChannel(BuildContext context) async {
    String url = channelUrl ?? 'https://www.youtube.com/$handle';

    // Try to launch in YouTube app first, fallback to browser
    final Uri youtubeUri = Uri.parse(url);

    try {
      // Skip canLaunchUrl check on some Android versions due to platform channel issues
      // Just try to launch directly
      final launched = await launchUrl(
        youtubeUri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open YouTube channel')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error opening YouTube: $e')));
      }
    }
  }
}
