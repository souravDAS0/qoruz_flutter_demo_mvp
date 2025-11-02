import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';
import '../../models/content_category.dart';

/// Content categories horizontal bar chart widget
class ContentCategoriesChart extends StatelessWidget {
  final List<ContentCategory> categories;

  const ContentCategoriesChart({super.key, required this.categories});

  // Define colors for different categories
  static const List<Color> _barColors = [
    Color(0xFF2563EB), // Blue
    Color(0xFF10B981), // Green
    Color(0xFFF59E0B), // Amber
    Color(0xFFEC4899), // Pink
    Color(0xFF8B5CF6), // Purple
    Color(0xFF06B6D4), // Cyan
    Color(0xFFEF4444), // Red
    Color(0xFF14B8A6), // Teal
  ];

  Color _getColorForIndex(int index) {
    return _barColors[index % _barColors.length];
  }

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.category_outlined,
                size: 20,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'CONTENT',
                style: AppTextStyles.overline.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'CONTENT CATEGORIES',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          // Top bar showing all categories proportionally
          Container(
            height: 20,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Row(
                children: categories.asMap().entries.map((entry) {
                  final index = entry.key;
                  final category = entry.value;
                  return Expanded(
                    flex: (category.percentage * 100).toInt(),
                    child: Container(color: _getColorForIndex(index)),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Individual category bars
          ...categories.asMap().entries.map((entry) {
            final index = entry.key;
            final category = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: _CategoryBar(
                category: category,
                color: _getColorForIndex(index),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _CategoryBar extends StatelessWidget {
  final ContentCategory category;
  final Color color;

  const _CategoryBar({required this.category, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Category icon and name
        Expanded(
          flex: 2,
          child: Row(
            children: [
              // Text(
              //   _getCategoryIcon(category.name),
              //   style: const TextStyle(fontSize: 16),
              // ),
              // const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  category.name,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        // Progress bar
        Expanded(
          flex: 4,
          child: Stack(
            children: [
              // Background
              Container(
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.backgroundCard,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              // Filled portion
              FractionallySizedBox(
                widthFactor: category.percentage / 100,
                child: Container(
                  height: 16,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        // Percentage
        SizedBox(
          width: 50,
          child: Text(
            category.formattedPercentage,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
