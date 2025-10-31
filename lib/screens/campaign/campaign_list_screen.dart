import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';
import '../../models/campaign_model.dart';
import '../../providers/campaign_provider.dart';
import '../../providers/auth_provider.dart';
import '../../routes/app_router.dart';

/// Campaign list screen
class CampaignListScreen extends StatefulWidget {
  const CampaignListScreen({super.key});

  @override
  State<CampaignListScreen> createState() => _CampaignListScreenState();
}

class _CampaignListScreenState extends State<CampaignListScreen> {
  int _currentIndex = 2; // Campaigns tab

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = context.read<AuthProvider>().user?.id ?? '';
      context.read<CampaignProvider>().loadCampaigns(userId);
    });
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        break;
      case 1:
        context.go(AppRoutes.home);
        break;
      case 2:
        // Already on campaigns
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
        title: const Text('My Campaigns'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.push(AppRoutes.campaignCreate);
            },
          ),
        ],
      ),
      body: Consumer<CampaignProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.campaigns.isEmpty) {
            return _EmptyState(
              onCreateCampaign: () {
                context.push(AppRoutes.campaignCreate);
              },
            );
          }

          return Column(
            children: [
              // Filter Tabs
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FilterTab(
                        label: 'All',
                        isSelected: provider.filterStatus == null,
                        onTap: () {
                          provider.filterByStatus(null);
                        },
                      ),
                      ...CampaignStatus.values.map((status) {
                        return _FilterTab(
                          label: status.displayName,
                          isSelected: provider.filterStatus == status,
                          onTap: () {
                            provider.filterByStatus(status);
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),

              // Campaign List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  itemCount: provider.campaigns.length,
                  itemBuilder: (context, index) {
                    final campaign = provider.campaigns[index];
                    return _CampaignCard(campaign: campaign);
                  },
                ),
              ),
            ],
          );
        },
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

class _EmptyState extends StatelessWidget {
  final VoidCallback onCreateCampaign;

  const _EmptyState({required this.onCreateCampaign});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.campaign_outlined,
              size: 80,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'No campaigns yet',
              style: AppTextStyles.h2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Create your first campaign to start collaborating with influencers',
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxxl),
            ElevatedButton.icon(
              onPressed: onCreateCampaign,
              icon: const Icon(Icons.add),
              label: const Text('Create Campaign'),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
        backgroundColor: AppColors.backgroundCard,
        selectedColor: AppColors.primaryOrange,
        labelStyle: AppTextStyles.bodyMedium.copyWith(
          color: isSelected ? AppColors.white : AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _CampaignCard extends StatelessWidget {
  final CampaignModel campaign;

  const _CampaignCard({required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    campaign.name,
                    style: AppTextStyles.h4,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _StatusBadge(status: campaign.status),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              campaign.type.displayName,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: campaign.targetPlatforms.map((platform) {
                return Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: Icon(
                    _getPlatformIcon(platform),
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Icon(Icons.calendar_today,
                    size: 16, color: AppColors.textTertiary),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '${DateFormat('MMM d').format(campaign.startDate)} - ${DateFormat('MMM d, yyyy').format(campaign.endDate)}',
                  style: AppTextStyles.bodySmall,
                ),
                const Spacer(),
                Icon(Icons.attach_money,
                    size: 16, color: AppColors.textTertiary),
                Text(
                  campaign.formattedBudget,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Icon(Icons.people, size: 16, color: AppColors.textTertiary),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '${campaign.selectedInfluencerIds.length} influencers',
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
            if (campaign.isOngoing) ...[
              const SizedBox(height: AppSpacing.md),
              LinearProgressIndicator(
                value: 0.6,
                backgroundColor: AppColors.backgroundCard,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.primaryOrange),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getPlatformIcon(platform) {
    return Icons.camera_alt;
  }
}

class _StatusBadge extends StatelessWidget {
  final CampaignStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case CampaignStatus.active:
        color = AppColors.success;
        break;
      case CampaignStatus.draft:
        color = AppColors.textTertiary;
        break;
      case CampaignStatus.completed:
        color = AppColors.blue;
        break;
      case CampaignStatus.cancelled:
        color = AppColors.error;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Text(
        status.displayName,
        style: AppTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
