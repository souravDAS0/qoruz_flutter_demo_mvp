import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';
import '../../models/audience_demographics.dart';

/// Geography Distribution Bar Chart Widget
class GeographyBarChart extends StatelessWidget {
  final List<LocationData> locations;
  final String title;

  const GeographyBarChart({
    super.key,
    required this.locations,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        ...locations.take(5).map((location) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _GeographyBar(
              location: location.name,
              percentage: location.percentage,
            ),
          );
        }),
      ],
    );
  }
}

class _GeographyBar extends StatelessWidget {
  final String location;
  final double percentage;

  const _GeographyBar({required this.location, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            location,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          flex: 7,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.backgroundCard,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percentage / 100,
                child: Container(
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.darkPurple,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        SizedBox(
          width: 50,
          child: Text(
            '${percentage.toStringAsFixed(2)}%',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
