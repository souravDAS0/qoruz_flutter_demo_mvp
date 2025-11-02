import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';

/// Age Distribution Bar Chart Widget
class AgeBarChart extends StatelessWidget {
  final Map<String, double> ageDistribution;

  const AgeBarChart({super.key, required this.ageDistribution});

  @override
  Widget build(BuildContext context) {
    // Sort age groups
    final sortedEntries = ageDistribution.entries.toList()
      ..sort((a, b) => _getAgeOrder(a.key).compareTo(_getAgeOrder(b.key)));

    return Column(
      children: sortedEntries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: _AgeBar(ageGroup: entry.key, percentage: entry.value),
        );
      }).toList(),
    );
  }

  int _getAgeOrder(String ageGroup) {
    switch (ageGroup) {
      case '13-17':
        return 1;
      case '18-24':
        return 2;
      case '25-34':
        return 3;
      case '35-44':
        return 4;
      case '45-64':
        return 5;
      case '45+':
        return 5;
      case '65+':
        return 6;
      default:
        return 99;
    }
  }
}

class _AgeBar extends StatelessWidget {
  final String ageGroup;
  final double percentage;

  const _AgeBar({required this.ageGroup, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            ageGroup,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.backgroundCard,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percentage / 100,
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: _getBarColor(percentage),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Positioned(
                right: 8,
                child: Text(
                  '${percentage.toStringAsFixed(2)}%',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getBarColor(double percentage) {
    if (percentage >= 40) return const Color(0xFFEF4444); // Red/Orange
    if (percentage >= 20) return AppColors.primaryOrange;
    return AppColors.teal;
  }
}
