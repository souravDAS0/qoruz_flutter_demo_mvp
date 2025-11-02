import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';
import '../../models/brand_collaboration.dart';

/// Brands Section Widget - Shows brand collaborations
class BrandsSection extends StatefulWidget {
  final List<BrandCollaboration> brands;

  const BrandsSection({super.key, required this.brands});

  @override
  State<BrandsSection> createState() => _BrandsSectionState();
}

class _BrandsSectionState extends State<BrandsSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    final categories = _getCategories();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<String> _getCategories() {
    final uniqueCategories = <String>{'All'};
    for (var brand in widget.brands) {
      uniqueCategories.add(brand.category.displayName);
    }
    return uniqueCategories.toList();
  }

  List<BrandCollaboration> _filterBrandsByCategory(String category) {
    if (category == 'All') return widget.brands;
    return widget.brands
        .where((brand) => brand.category.displayName == category)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final categories = _getCategories();

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
                    Icons.business_outlined,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'BRANDS',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'BRAND MENTIONS',
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              if (categories.length > 1) ...[
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: AppColors.primaryOrange,
                  unselectedLabelColor: AppColors.textSecondary,
                  indicatorColor: AppColors.primaryOrange,
                  indicatorWeight: 2,
                  labelStyle: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  dividerColor: AppColors.border,
                  dividerHeight: 1,
                  tabs: categories.map((cat) => Tab(text: cat)).toList(),
                ),
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  height: 200,
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: categories.map((category) {
                      return _BrandGrid(
                        brands: _filterBrandsByCategory(category),
                      );
                    }).toList(),
                  ),
                ),
              ] else ...[
                _BrandGrid(brands: widget.brands),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _BrandGrid extends StatelessWidget {
  final List<BrandCollaboration> brands;

  const _BrandGrid({required this.brands});

  @override
  Widget build(BuildContext context) {
    if (brands.isEmpty) {
      return Center(
        child: Text(
          'No brands available',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(0),
      scrollDirection: Axis.horizontal,

      itemCount: brands.length,
      itemBuilder: (context, index) {
        final brand = brands[index];
        return Padding(
          padding: EdgeInsets.only(
            right: index < brands.length - 1 ? AppSpacing.sm : 0,
          ),
          child: _BrandCard(brand: brand),
        );
      },
    );
  }
}

class _BrandCard extends StatelessWidget {
  final BrandCollaboration brand;

  const _BrandCard({required this.brand});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 160,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: brand.imageUrl.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      brand.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.business,
                          size: 24,
                          color: AppColors.textTertiary,
                        );
                      },
                    ),
                  )
                : const Icon(
                    Icons.business,
                    size: 24,
                    color: AppColors.textTertiary,
                  ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            brand.name,
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            brand.handle,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textTertiary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            '${brand.formattedPostCount} posts',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.primaryOrange,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
