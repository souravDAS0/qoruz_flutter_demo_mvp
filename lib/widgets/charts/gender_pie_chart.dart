import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';

/// Gender Distribution Pie Chart Widget
class GenderPieChart extends StatelessWidget {
  final Map<String, double> genderDistribution;

  const GenderPieChart({super.key, required this.genderDistribution});

  @override
  Widget build(BuildContext context) {
    final malePercentage = genderDistribution['Male'] ?? 0.0;
    final femalePercentage = genderDistribution['Female'] ?? 0.0;

    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Pie Chart
          SizedBox(
            width: 180,
            height: 180,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 55,
                    startDegreeOffset: -90,
                    sections: [
                      PieChartSectionData(
                        color: const Color.fromARGB(
                          255,
                          15,
                          76,
                          173,
                        ), // Blue for Male
                        value: malePercentage,
                        title: '',
                        radius: 45,
                        borderSide: BorderSide.none,
                      ),
                      PieChartSectionData(
                        color: const Color.fromARGB(
                          255,
                          90,
                          137,
                          213,
                        ), // Pink for Female
                        value: femalePercentage,
                        title: '',
                        radius: 45,
                        borderSide: BorderSide.none,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${malePercentage.toStringAsFixed(1)} %',
                      style: AppTextStyles.h3.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Male Audience',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xl),
          // Legend
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _LegendItem(
                color: const Color.fromARGB(255, 15, 76, 173),
                label: 'Male',
                percentage: malePercentage,
              ),
              const SizedBox(height: AppSpacing.sm),
              _LegendItem(
                color: const Color.fromARGB(255, 90, 137, 213),
                label: 'Female',
                percentage: femalePercentage,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final double percentage;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              '${percentage.toStringAsFixed(1)}%',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
