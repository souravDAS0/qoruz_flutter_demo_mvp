import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';

/// Age Distribution Bar Chart Widget
class AgeBarChart extends StatefulWidget {
  final Map<String, double> ageDistribution;

  const AgeBarChart({super.key, required this.ageDistribution});

  @override
  State<AgeBarChart> createState() => _AgeBarChartState();
}

class _AgeBarChartState extends State<AgeBarChart> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    // Sort age groups
    final sortedEntries = widget.ageDistribution.entries.toList()
      ..sort((a, b) => _getAgeOrder(a.key).compareTo(_getAgeOrder(b.key)));

    return VisibilityDetector(
      key: const Key('age-bar-chart'),
      onVisibilityChanged: (visibilityInfo) {
        if (!_isVisible && visibilityInfo.visibleFraction > 0.2) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: Column(
        children: sortedEntries.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: _AgeBar(
              ageGroup: entry.value.key,
              percentage: entry.value.value,
              index: entry.key,
              shouldAnimate: _isVisible,
            ),
          );
        }).toList(),
      ),
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

class _AgeBar extends StatefulWidget {
  final String ageGroup;
  final double percentage;
  final int index;
  final bool shouldAnimate;

  const _AgeBar({
    required this.ageGroup,
    required this.percentage,
    required this.index,
    required this.shouldAnimate,
  });

  @override
  State<_AgeBar> createState() => _AgeBarState();
}

class _AgeBarState extends State<_AgeBar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = Tween<double>(begin: 0.0, end: widget.percentage).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(_AgeBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldAnimate && !_hasAnimated) {
      _hasAnimated = true;
      // Stagger the animation based on index
      Future.delayed(Duration(milliseconds: widget.index * 100), () {
        if (mounted) {
          _animationController.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final animatedPercentage = _animation.value;
        return Row(
          children: [
            SizedBox(
              width: 60,
              child: Text(
                widget.ageGroup,
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
                    widthFactor: animatedPercentage / 100,
                    child: Container(
                      height: 32,
                      decoration: BoxDecoration(
                        color: _getBarColor(widget.percentage),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    child: Text(
                      '${animatedPercentage.toStringAsFixed(2)}%',
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
      },
    );
  }

  Color _getBarColor(double percentage) {
    if (percentage >= 40) return const Color(0xFFEF4444); // Red/Orange
    if (percentage >= 20) return AppColors.primaryOrange;
    return AppColors.teal;
  }
}
