import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';
import '../../models/audience_demographics.dart';

/// Geography Distribution Bar Chart Widget
class GeographyBarChart extends StatefulWidget {
  final List<LocationData> locations;
  final String title;

  const GeographyBarChart({
    super.key,
    required this.locations,
    required this.title,
  });

  @override
  State<GeographyBarChart> createState() => _GeographyBarChartState();
}

class _GeographyBarChartState extends State<GeographyBarChart> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('geography-bar-chart-${widget.title}'),
      onVisibilityChanged: (visibilityInfo) {
        if (!_isVisible && visibilityInfo.visibleFraction > 0.2) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ...widget.locations.take(5).toList().asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _GeographyBar(
                location: entry.value.name,
                percentage: entry.value.percentage,
                index: entry.key,
                shouldAnimate: _isVisible,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _GeographyBar extends StatefulWidget {
  final String location;
  final double percentage;
  final int index;
  final bool shouldAnimate;

  const _GeographyBar({
    required this.location,
    required this.percentage,
    required this.index,
    required this.shouldAnimate,
  });

  @override
  State<_GeographyBar> createState() => _GeographyBarState();
}

class _GeographyBarState extends State<_GeographyBar>
    with SingleTickerProviderStateMixin {
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
  void didUpdateWidget(_GeographyBar oldWidget) {
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
            Expanded(
              flex: 3,
              child: Text(
                widget.location,
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
                    widthFactor: animatedPercentage / 100,
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
                '${animatedPercentage.toStringAsFixed(2)}%',
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        );
      },
    );
  }
}
