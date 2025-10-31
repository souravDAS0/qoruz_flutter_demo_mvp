import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';
import '../../models/influencer_model.dart';
import '../../models/social_platform.dart';
import '../../providers/influencer_provider.dart';
import '../../routes/app_router.dart';
import '../../widgets/influencer_card.dart';

/// Main home screen with influencer discovery
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load influencers when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InfluencerProvider>().loadInfluencers();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        // Already on home
        break;
      case 1:
        // Search - just focus search field
        break;
      case 2:
        context.go(AppRoutes.campaigns);
        break;
      case 3:
        context.go(AppRoutes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QORUZ',
          style: AppTextStyles.h3.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications - Coming soon!')),
              );
            },
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search influencers...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          context
                              .read<InfluencerProvider>()
                              .searchInfluencers('');
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                context.read<InfluencerProvider>().searchInfluencers(value);
                setState(() {});
              },
            ),
          ),

          // Filter Chips
          SizedBox(
            height: 50,
            child: Consumer<InfluencerProvider>(
              builder: (context, provider, child) {
                return ListView(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  children: [
                    _FilterChip(
                      label: 'All',
                      isSelected: provider.selectedCategory == null &&
                          provider.selectedPlatform == null,
                      onTap: () {
                        provider.clearFilters();
                      },
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    // Platform filters
                    ...SocialPlatform.values.map((platform) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(right: AppSpacing.sm),
                        child: _FilterChip(
                          label: platform.displayName,
                          isSelected: provider.selectedPlatform == platform,
                          onTap: () {
                            provider.filterByPlatform(
                              provider.selectedPlatform == platform
                                  ? null
                                  : platform,
                            );
                          },
                        ),
                      );
                    }),
                    // Category filters
                    ...InfluencerCategory.values.take(5).map((category) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(right: AppSpacing.sm),
                        child: _FilterChip(
                          label: category.displayName,
                          isSelected: provider.selectedCategory == category,
                          onTap: () {
                            provider.filterByCategory(
                              provider.selectedCategory == category
                                  ? null
                                  : category,
                            );
                          },
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          ),

          // Influencer Grid
          Expanded(
            child: Consumer<InfluencerProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (provider.influencers.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          'No influencers found',
                          style: AppTextStyles.h3,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Try adjusting your filters',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.md,
                  ),
                  itemCount: provider.influencers.length,
                  itemBuilder: (context, index) {
                    final influencer = provider.influencers[index];
                    return InfluencerCard(
                      influencer: influencer,
                      onTap: () {
                        context.push('/influencer/${influencer.id}');
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.campaign_outlined),
            activeIcon: Icon(Icons.campaign),
            label: 'Campaigns',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
      backgroundColor: AppColors.backgroundCard,
      selectedColor: AppColors.primaryOrange,
      labelStyle: AppTextStyles.bodyMedium.copyWith(
        color: isSelected ? AppColors.white : AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
    );
  }
}
