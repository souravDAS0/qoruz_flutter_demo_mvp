import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';

/// Ratio Metric Card Widget - For Likes-Comments Ratio and Recurring Viewership
class RatioMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String label;
  final String? subtitle;
  final String? tooltipMessage;

  const RatioMetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.label,
    this.subtitle,
    this.tooltipMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.overline.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              if (tooltipMessage != null)
                Tooltip(
                  message: tooltipMessage!,
                  child: Icon(
                    Icons.info_outline,
                    size: 16,
                    color: AppColors.textTertiary,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: AppTextStyles.h3.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getLabelColor(label).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      label,
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        color: _getLabelColor(label),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              subtitle!,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getLabelColor(String label) {
    switch (label.toLowerCase()) {
      case 'excellent':
        return const Color(0xFF10B981); // Green
      case 'very good':
        return const Color(0xFF3B82F6); // Blue
      case 'good':
        return AppColors.teal;
      case 'average':
        return AppColors.warning;
      case 'below average':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }
}
