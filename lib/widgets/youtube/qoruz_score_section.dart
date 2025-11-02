import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';
import '../../models/social_platform.dart';
import '../charts/qoruz_score_pie_chart.dart';

/// Qoruz Score Section with Pie Chart and Insights
class QoruzScoreSection extends StatelessWidget {
  final PlatformStats platform;

  const QoruzScoreSection({super.key, required this.platform});

  @override
  Widget build(BuildContext context) {
    final score = platform.qoruzScore ?? 0.0;
    final insights = platform.insights ?? [];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      // decoration: BoxDecoration(
      //   color: AppColors.white,
      //   borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      //   border: Border.all(color: AppColors.border),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'QORUZ SCORE',
            style: AppTextStyles.overline.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QoruzScorePieChart(score: score, rank: platform.qoruzScoreRank),
              const SizedBox(width: AppSpacing.xl),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'INSIGHTS FOR YOU',
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ...insights.map(
                      (insight) => _InsightItem(insight: insight),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InsightItem extends StatelessWidget {
  final String insight;

  const _InsightItem({required this.insight});

  @override
  Widget build(BuildContext context) {
    final icon = _getInsightIcon(insight);
    final color = _getInsightColor(insight);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 14, color: color),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              insight,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getInsightIcon(String insight) {
    final lowerInsight = insight.toLowerCase();
    if (lowerInsight.contains('popular') || lowerInsight.contains('high')) {
      return Icons.trending_up;
    }
    if (lowerInsight.contains('moderate') || lowerInsight.contains('average')) {
      return Icons.warning_amber_rounded;
    }
    if (lowerInsight.contains('low') || lowerInsight.contains('below')) {
      return Icons.trending_down;
    }
    return Icons.info_outline;
  }

  Color _getInsightColor(String insight) {
    final lowerInsight = insight.toLowerCase();
    if (lowerInsight.contains('popular') || lowerInsight.contains('high')) {
      return const Color(0xFF10B981); // Green
    }
    if (lowerInsight.contains('moderate') || lowerInsight.contains('average')) {
      return AppColors.warning;
    }
    if (lowerInsight.contains('low') || lowerInsight.contains('below')) {
      return AppColors.error;
    }
    return const Color(0xFF3B82F6); // Blue
  }
}
