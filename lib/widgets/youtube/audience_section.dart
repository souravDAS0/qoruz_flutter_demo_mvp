import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';
import '../../models/audience_demographics.dart';
import '../charts/age_bar_chart.dart';
import '../charts/gender_pie_chart.dart';
import '../charts/geography_bar_chart.dart';

/// Audience Section Widget - Shows demographics with charts
class AudienceSection extends StatelessWidget {
  final AudienceDemographics demographics;

  const AudienceSection({super.key, required this.demographics});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSpacing.radiusMd),
              topRight: Radius.circular(AppSpacing.radiusMd),
            ),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF1F4F8),
                Color(0x00F1F4F8), // transparent with F1F4F8 color
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.people_outline,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'AUDIENCE',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // Top Country
              if (demographics.topCountries.isNotEmpty) ...[
                _InfoCard(
                  title: 'TOP COUNTRY',
                  value: demographics.topCountries.first.name,
                  subtitle:
                      'Audience from ${demographics.topCountries.first.name} is ${demographics.topCountries.first.percentage.toStringAsFixed(2)}%',
                ),
                const SizedBox(height: AppSpacing.lg),
              ],

              // Top Gender
              if (demographics.genderDistribution.isNotEmpty) ...[
                _InfoCard(
                  title: 'TOP GENDER',
                  value: _getTopGender(demographics.genderDistribution),
                  subtitle:
                      'Total ${_getTopGender(demographics.genderDistribution).toLowerCase()} audience is ${_getTopGenderPercentage(demographics.genderDistribution)}%',
                ),
                const SizedBox(height: AppSpacing.lg),
              ],

              // Top Age Group
              if (demographics.ageDistribution.isNotEmpty) ...[
                _InfoCard(
                  title: 'TOP AGE GROUP',
                  value:
                      '${_getTopAgeGroup(demographics.ageDistribution)} Years',
                  subtitle:
                      'Total audience in this age group is ${_getTopAgePercentage(demographics.ageDistribution)}%',
                ),
                const SizedBox(height: AppSpacing.xl),
              ],

              // Geography
              if (demographics.topCountries.isNotEmpty) ...[
                GeographyBarChart(
                  locations: demographics.topCountries,
                  title: 'AUDIENCE GEOGRAPHY',
                ),
                const SizedBox(height: AppSpacing.xl),
              ],

              // Age Distribution
              if (demographics.ageDistribution.isNotEmpty) ...[
                Text(
                  'AUDIENCE AGE GROUP',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                AgeBarChart(ageDistribution: demographics.ageDistribution),
                const SizedBox(height: AppSpacing.xl),
              ],

              // Gender Distribution
              if (demographics.genderDistribution.isNotEmpty) ...[
                Text(
                  'AUDIENCE GENDER',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                GenderPieChart(
                  genderDistribution: demographics.genderDistribution,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  String _getTopGender(Map<String, double> distribution) {
    return distribution.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  String _getTopGenderPercentage(Map<String, double> distribution) {
    return distribution.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .value
        .toStringAsFixed(1);
  }

  String _getTopAgeGroup(Map<String, double> distribution) {
    return distribution.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  String _getTopAgePercentage(Map<String, double> distribution) {
    return distribution.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .value
        .toStringAsFixed(2);
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;

  const _InfoCard({
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.overline.copyWith(color: AppColors.textTertiary),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.h4.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
