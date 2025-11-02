import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';
import '../../models/social_platform.dart';
import '../../models/insight_model.dart';
import '../charts/qoruz_score_pie_chart.dart';

/// Qoruz Score Section with Pie Chart and Insights
class QoruzScoreSection extends StatelessWidget {
  final PlatformStats platform;

  const QoruzScoreSection({super.key, required this.platform});

  @override
  Widget build(BuildContext context) {
    final score = platform.qoruzScore ?? 0.0;
    final insights = _generateDefaultInsights(platform);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),

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
              QoruzScorePieChart(
                score: score,
                rank: platform.qoruzScoreRank ?? 'TOP 1%',
              ),
              const SizedBox(width: AppSpacing.xl),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'INSIGHTS FOR YOU',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ..._buildInsightWidgets(insights),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Insight> _generateDefaultInsights(PlatformStats platform) {
    final insights = <Insight>[];

    // Add insights from platform if available
    if (platform.insights != null && platform.insights!.isNotEmpty) {
      insights.addAll(platform.insights!);
    }

    // Engagement insight
    if (platform.engagementRate >= 0.7) {
      insights.add(
        Insight(
          type: InsightType.positive,
          title: 'Highly engaging audience',
          subtitle:
              '${platform.formattedEngagement} of the followers of this creator engages with their content.',
        ),
      );
    }

    // Comments insight
    if (platform.avgComments != null && platform.avgLikes != null) {
      final ratio = platform.avgLikes! / platform.avgComments!;
      if (ratio > 100) {
        insights.add(
          Insight(
            type: InsightType.warning,
            title: 'Moderate ability to drive comments',
            subtitle:
                'This creator drives ${(platform.avgComments! / platform.avgLikes! * 100).toStringAsFixed(2)} comments per 100 likes.',
          ),
        );
      }
    }

    return insights;
  }
}

List<Widget> _buildInsightWidgets(List<Insight> insights) {
  return insights
      .map<Widget>((insight) => _InsightItem(insight: insight))
      .toList();
}

class _InsightItem extends StatelessWidget {
  final Insight insight;

  const _InsightItem({required this.insight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 16,
            height: 16,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: _getIconBackgroundColor(),
              shape: BoxShape.circle,
            ),
            child: Icon(_getIcon(), size: 12, color: _getIconColor()),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  insight.title,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  insight.subtitle,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon() {
    switch (insight.type) {
      case InsightType.positive:
        return Icons.add;
      case InsightType.negative:
        return Icons.remove;
      case InsightType.warning:
        return Icons.remove;
    }
  }

  Color _getIconColor() {
    switch (insight.type) {
      case InsightType.positive:
        return const Color(0xFF10B981); // Green
      case InsightType.negative:
        return const Color(0xFFEF4444); // Red
      case InsightType.warning:
        return const Color(0xFFF59E0B); // Orange
    }
  }

  Color _getIconBackgroundColor() {
    switch (insight.type) {
      case InsightType.positive:
        return const Color(0xFFD1FAE5); // Light Green
      case InsightType.negative:
        return const Color(0xFFFEE2E2); // Light Red
      case InsightType.warning:
        return const Color(0xFFFEF3C7); // Light Orange
    }
  }
}
