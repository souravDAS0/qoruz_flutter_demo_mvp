import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

/// Qoruz Score Pie Chart Widget
class QoruzScorePieChart extends StatelessWidget {
  final double score;
  final String? rank;

  const QoruzScorePieChart({super.key, required this.score, this.rank});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 45,
              startDegreeOffset: -90,
              sections: [
                PieChartSectionData(
                  color: _getScoreColor(score),
                  value: score,
                  title: '',
                  radius: 12,
                  borderSide: BorderSide.none,
                ),
                PieChartSectionData(
                  color: AppColors.border,
                  value: 10 - score,
                  title: '',
                  radius: 12,
                  borderSide: BorderSide.none,
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                score.toStringAsFixed(2),
                style: AppTextStyles.h3.copyWith(
                  fontWeight: FontWeight.w700,
                  color: _getScoreColor(score),
                ),
              ),
              if (rank != null)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    rank!,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 8.0) return const Color.fromARGB(255, 7, 92, 63); // Green
    if (score >= 7.0) return const Color.fromARGB(255, 22, 95, 213); // Blue
    if (score >= 5.0) return AppColors.primaryOrange;
    if (score >= 3.0) return AppColors.warning;
    return AppColors.error;
  }
}
