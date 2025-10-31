import '../models/influencer_model.dart';
import '../models/social_platform.dart';
import '../models/campaign_model.dart';

/// Mock data service for MVP
class MockDataService {
  // Sample influencers
  static List<InfluencerModel> getInfluencers() {
    return [
      InfluencerModel(
        id: '1',
        name: 'Sarah Johnson',
        profileImage: 'https://i.pravatar.cc/300?img=1',
        category: InfluencerCategory.fashion,
        platforms: [
          PlatformStats(
            platform: SocialPlatform.instagram,
            followers: 125000,
            engagementRate: 5.2,
            avgViews: 15000,
            handle: '@sarahjfashion',
          ),
          PlatformStats(
            platform: SocialPlatform.tiktok,
            followers: 85000,
            engagementRate: 7.8,
            avgViews: 25000,
            handle: '@sarahjstyle',
          ),
        ],
        bio:
            'Fashion enthusiast & style curator. Sharing daily outfit inspiration and fashion tips.',
        location: 'Los Angeles, CA',
        languages: ['English', 'Spanish'],
        isVerified: true,
        brandCollaborations: ['Nike', 'Zara', 'H&M', 'Adidas'],
        portfolioImages: [
          'https://picsum.photos/400/600?random=1',
          'https://picsum.photos/400/600?random=2',
          'https://picsum.photos/400/600?random=3',
          'https://picsum.photos/400/600?random=4',
          'https://picsum.photos/400/600?random=5',
          'https://picsum.photos/400/600?random=6',
        ],
        joinedDate: DateTime(2022, 3, 15),
      ),
      InfluencerModel(
        id: '2',
        name: 'Alex Chen',
        profileImage: 'https://i.pravatar.cc/300?img=12',
        category: InfluencerCategory.tech,
        platforms: [
          PlatformStats(
            platform: SocialPlatform.youtube,
            followers: 450000,
            engagementRate: 4.5,
            avgViews: 85000,
            handle: '@alextech',
          ),
          PlatformStats(
            platform: SocialPlatform.twitter,
            followers: 95000,
            engagementRate: 3.2,
            avgViews: 8000,
            handle: '@alexchentech',
          ),
        ],
        bio:
            'Tech reviewer & gadget enthusiast. Honest reviews of the latest tech products.',
        location: 'San Francisco, CA',
        languages: ['English', 'Mandarin'],
        isVerified: true,
        brandCollaborations: ['Apple', 'Samsung', 'Sony', 'Google'],
        portfolioImages: [
          'https://picsum.photos/400/600?random=7',
          'https://picsum.photos/400/600?random=8',
          'https://picsum.photos/400/600?random=9',
          'https://picsum.photos/400/600?random=10',
        ],
        joinedDate: DateTime(2021, 6, 20),
      ),
      InfluencerModel(
        id: '3',
        name: 'Emma Rodriguez',
        profileImage: 'https://i.pravatar.cc/300?img=5',
        category: InfluencerCategory.beauty,
        platforms: [
          PlatformStats(
            platform: SocialPlatform.instagram,
            followers: 320000,
            engagementRate: 6.8,
            avgViews: 42000,
            handle: '@emmabeauty',
          ),
          PlatformStats(
            platform: SocialPlatform.youtube,
            followers: 180000,
            engagementRate: 5.5,
            avgViews: 35000,
            handle: '@emmamakeup',
          ),
        ],
        bio:
            'Professional makeup artist. Tutorials, reviews, and beauty tips for all skin types.',
        location: 'Miami, FL',
        languages: ['English', 'Spanish', 'Portuguese'],
        isVerified: true,
        brandCollaborations: ['Sephora', 'MAC', 'Fenty Beauty', 'Maybelline'],
        portfolioImages: [
          'https://picsum.photos/400/600?random=11',
          'https://picsum.photos/400/600?random=12',
          'https://picsum.photos/400/600?random=13',
          'https://picsum.photos/400/600?random=14',
          'https://picsum.photos/400/600?random=15',
        ],
        joinedDate: DateTime(2020, 9, 10),
      ),
      InfluencerModel(
        id: '4',
        name: 'David Kim',
        profileImage: 'https://i.pravatar.cc/300?img=13',
        category: InfluencerCategory.fitness,
        platforms: [
          PlatformStats(
            platform: SocialPlatform.instagram,
            followers: 280000,
            engagementRate: 7.5,
            avgViews: 38000,
            handle: '@davidfitness',
          ),
          PlatformStats(
            platform: SocialPlatform.tiktok,
            followers: 420000,
            engagementRate: 9.2,
            avgViews: 120000,
            handle: '@davidworkout',
          ),
        ],
        bio:
            'Certified personal trainer. Daily workout routines and nutrition tips.',
        location: 'New York, NY',
        languages: ['English', 'Korean'],
        isVerified: true,
        brandCollaborations: ['Nike', 'GymShark', 'MyProtein', 'Lululemon'],
        portfolioImages: [
          'https://picsum.photos/400/600?random=16',
          'https://picsum.photos/400/600?random=17',
          'https://picsum.photos/400/600?random=18',
          'https://picsum.photos/400/600?random=19',
        ],
        joinedDate: DateTime(2021, 1, 5),
      ),
      InfluencerModel(
        id: '5',
        name: 'Lisa Anderson',
        profileImage: 'https://i.pravatar.cc/300?img=9',
        category: InfluencerCategory.food,
        platforms: [
          PlatformStats(
            platform: SocialPlatform.instagram,
            followers: 195000,
            engagementRate: 6.2,
            avgViews: 28000,
            handle: '@lisafoodie',
          ),
          PlatformStats(
            platform: SocialPlatform.youtube,
            followers: 150000,
            engagementRate: 4.8,
            avgViews: 32000,
            handle: '@lisacooks',
          ),
        ],
        bio: 'Food blogger & recipe creator. Easy recipes for busy people.',
        location: 'Austin, TX',
        languages: ['English'],
        isVerified: false,
        brandCollaborations: ['HelloFresh', 'KitchenAid', 'Blue Apron'],
        portfolioImages: [
          'https://picsum.photos/400/600?random=20',
          'https://picsum.photos/400/600?random=21',
          'https://picsum.photos/400/600?random=22',
        ],
        joinedDate: DateTime(2022, 2, 18),
      ),
      InfluencerModel(
        id: '6',
        name: 'Marcus Thompson',
        profileImage: 'https://i.pravatar.cc/300?img=14',
        category: InfluencerCategory.travel,
        platforms: [
          PlatformStats(
            platform: SocialPlatform.instagram,
            followers: 380000,
            engagementRate: 5.9,
            avgViews: 45000,
            handle: '@marcustravels',
          ),
          PlatformStats(
            platform: SocialPlatform.youtube,
            followers: 290000,
            engagementRate: 4.2,
            avgViews: 55000,
            handle: '@marcusadventures',
          ),
        ],
        bio:
            'Travel photographer & adventure seeker. Exploring the world one destination at a time.',
        location: 'Seattle, WA',
        languages: ['English', 'French', 'Japanese'],
        isVerified: true,
        brandCollaborations: [
          'Airbnb',
          'GoPro',
          'The North Face',
          'Booking.com'
        ],
        portfolioImages: [
          'https://picsum.photos/400/600?random=23',
          'https://picsum.photos/400/600?random=24',
          'https://picsum.photos/400/600?random=25',
          'https://picsum.photos/400/600?random=26',
          'https://picsum.photos/400/600?random=27',
        ],
        joinedDate: DateTime(2020, 7, 12),
      ),
    ];
  }

  // Filter influencers by category
  static List<InfluencerModel> filterByCategory(
      InfluencerCategory? category) {
    final influencers = getInfluencers();
    if (category == null) return influencers;
    return influencers.where((i) => i.category == category).toList();
  }

  // Filter influencers by platform
  static List<InfluencerModel> filterByPlatform(SocialPlatform? platform) {
    final influencers = getInfluencers();
    if (platform == null) return influencers;
    return influencers
        .where((i) => i.platforms.any((p) => p.platform == platform))
        .toList();
  }

  // Search influencers by name
  static List<InfluencerModel> searchInfluencers(String query) {
    final influencers = getInfluencers();
    if (query.isEmpty) return influencers;
    final lowerQuery = query.toLowerCase();
    return influencers
        .where((i) =>
            i.name.toLowerCase().contains(lowerQuery) ||
            i.bio.toLowerCase().contains(lowerQuery) ||
            i.category.displayName.toLowerCase().contains(lowerQuery))
        .toList();
  }

  // Get influencer by ID
  static InfluencerModel? getInfluencerById(String id) {
    try {
      return getInfluencers().firstWhere((i) => i.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get sample campaigns
  static List<CampaignModel> getCampaigns(String userId) {
    return [
      CampaignModel(
        id: '1',
        name: 'Summer Fashion Collection 2025',
        description:
            'Promote our new summer collection with lifestyle content',
        type: CampaignType.sponsoredPost,
        status: CampaignStatus.active,
        budget: 5000,
        startDate: DateTime.now().subtract(const Duration(days: 5)),
        endDate: DateTime.now().add(const Duration(days: 25)),
        targetPlatforms: [SocialPlatform.instagram, SocialPlatform.tiktok],
        contentRequirements:
            '3 Instagram posts, 5 stories, 2 TikTok videos featuring our summer collection',
        selectedInfluencerIds: ['1', '3'],
        creatorId: userId,
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
      ),
      CampaignModel(
        id: '2',
        name: 'Tech Product Launch',
        description: 'Product review for our new smartphone model',
        type: CampaignType.productReview,
        status: CampaignStatus.draft,
        budget: 8000,
        startDate: DateTime.now().add(const Duration(days: 7)),
        endDate: DateTime.now().add(const Duration(days: 37)),
        targetPlatforms: [SocialPlatform.youtube, SocialPlatform.twitter],
        contentRequirements:
            'Detailed review video, unboxing, feature highlights',
        selectedInfluencerIds: ['2'],
        creatorId: userId,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];
  }
}
