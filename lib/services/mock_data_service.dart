import '../models/influencer_model.dart';
import '../models/social_platform.dart';
import '../models/campaign_model.dart';
import '../models/content_category.dart';
import '../models/audience_demographics.dart';
import '../models/video_model.dart';
import '../models/brand_collaboration.dart';

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
            avgLikes: 6500,
            avgComments: 245,
            avgShares: 180,
            totalPosts: 1247,
            estimatedReach: 87500,
            qoruzScore: 8.7,
          ),
          PlatformStats(
            platform: SocialPlatform.youtube,
            followers: 68000,
            engagementRate: 4.8,
            avgViews: 12000,
            totalVideos: 1500,
            avgViewsVideos: 534600,
            avgViewsShorts: 450500,
            avgViews7Days: 2200000,
            avgLikesVideos: 11800,
            avgLikesShorts: 57300,
            avgCommentsVideos: 674,
            avgCommentsShorts: 710,
            handle: '@sarah_henley',
            avgLikes: 580,
            avgComments: 95,
            avgShares: 42,
            totalPosts: 156,
            estimatedReach: 45000,
            qoruzScore: 8.4,
            likesCommentsRatio: 5.72,
            recurringViewership: 4.28,
            insights: [
              'Popular content - This creator drives 22.03 likes per 1000 views.',
              'High video viewership - This Creator generates 4.28 views per 100 followers.',
              'Moderate ability to drive comments - This creator drives 1.26 comments per 1000 views.',
            ],
            channelUrl: 'https://www.youtube.com/@sarah_henley',
          ),
          PlatformStats(
            platform: SocialPlatform.twitter,
            followers: 42000,
            engagementRate: 2.9,
            avgViews: 8500,
            handle: '@sarahjfashion',
            avgLikes: 1220,
            avgComments: 87,
            avgShares: 156,
            totalPosts: 3450,
            estimatedReach: 28000,
            qoruzScore: 6.8,
          ),
          PlatformStats(
            platform: SocialPlatform.facebook,
            followers: 95000,
            engagementRate: 3.5,
            avgViews: 11000,
            handle: 'sarahjfashion',
            avgLikes: 3325,
            avgComments: 178,
            avgShares: 290,
            totalPosts: 892,
            estimatedReach: 65000,
            qoruzScore: 7.5,
          ),
        ],
        bio:
            'Fashion enthusiast & style curator. Sharing daily outfit inspiration and fashion tips.',
        location: 'Los Angeles, CA',
        languages: ['English', 'Spanish'],
        isVerified: true,
        brandCollaborations: [
          BrandCollaboration(
            id: 'nike',
            name: 'Nike',
            imageUrl: 'https://logo.clearbit.com/nike.com',
            handle: '@nike',
            postCount: 45,
            category: BrandCategory.fashion,
          ),
          BrandCollaboration(
            id: 'zara',
            name: 'Zara',
            imageUrl: 'https://logo.clearbit.com/zara.com',
            handle: '@zara',
            postCount: 32,
            category: BrandCategory.fashion,
          ),
          BrandCollaboration(
            id: 'hm',
            name: 'H&M',
            imageUrl: 'https://logo.clearbit.com/hm.com',
            handle: '@hm',
            postCount: 28,
            category: BrandCategory.fashion,
          ),
          BrandCollaboration(
            id: 'adidas',
            name: 'Adidas',
            imageUrl: 'https://logo.clearbit.com/adidas.com',
            handle: '@adidas',
            postCount: 38,
            category: BrandCategory.sports,
          ),
        ],
        portfolioImages: [
          'https://picsum.photos/400/600?random=1',
          'https://picsum.photos/400/600?random=2',
          'https://picsum.photos/400/600?random=3',
          'https://picsum.photos/400/600?random=4',
          'https://picsum.photos/400/600?random=5',
          'https://picsum.photos/400/600?random=6',
        ],
        joinedDate: DateTime(2022, 3, 15),
        contentCategories: [
          ContentCategory(name: 'Fashion', percentage: 65.5),
          ContentCategory(name: 'Lifestyle', percentage: 18.2),
          ContentCategory(name: 'Beauty', percentage: 12.8),
          ContentCategory(name: 'Travel', percentage: 3.5),
        ],
        audienceDemographics: AudienceDemographics(
          genderDistribution: {'Female': 72.5, 'Male': 26.8, 'Other': 0.7},
          ageDistribution: {
            '13-17': 8.5,
            '18-24': 42.3,
            '25-34': 31.2,
            '35-44': 12.8,
            '45+': 5.2,
          },
          topCities: [
            LocationData(name: 'Los Angeles', percentage: 18.5),
            LocationData(name: 'New York', percentage: 15.2),
            LocationData(name: 'Miami', percentage: 9.8),
          ],
          topStates: [
            LocationData(name: 'California', percentage: 28.5),
            LocationData(name: 'New York', percentage: 18.2),
            LocationData(name: 'Florida', percentage: 12.7),
          ],
          topCountries: [
            LocationData(name: 'United States', percentage: 68.5),
            LocationData(name: 'Canada', percentage: 12.3),
            LocationData(name: 'United Kingdom', percentage: 8.9),
          ],
          audienceCredibility: 94.2,
        ),
        hashtags: [
          '#fashion',
          '#ootd',
          '#style',
          '#fashionblogger',
          '#outfitoftheday',
          '#fashionstyle',
          '#instafashion',
          '#streetstyle',
        ],
      ),
      InfluencerModel(
        id: '2',
        name: 'Alex Chen',
        profileImage: 'https://i.pravatar.cc/300?img=12',
        category: InfluencerCategory.tech,
        platforms: [
          PlatformStats(
            platform: SocialPlatform.youtube,
            followers: 12500000,
            engagementRate: 0.07,
            avgViews: 534600,
            handle: '@MrAlexTech',
            avgLikes: 11800,
            avgComments: 674,
            avgShares: 320,
            totalPosts: 1500,
            estimatedReach: 315000,
            qoruzScore: 8.17,
            // YouTube-specific fields
            subscribers: 12500000,
            totalVideos: 1500,
            totalShorts: 450,
            avgViewsVideos: 534600,
            avgViewsShorts: 450500,
            avgViews7Days: 2200000,
            avgLikesVideos: 11800,
            avgLikesShorts: 57300,
            avgCommentsVideos: 674,
            avgCommentsShorts: 710,
            likesCommentsRatio: 5.72,
            recurringViewership: 4.28,

            qoruzScoreRank: 'Top 1%',
            insights: [
              'Popular content - This creator drives 22.03 likes per 1000 views.',
              'High video viewership - This Creator generates 4.28 views per 100 followers.',
              'Moderate ability to drive comments - This creator drives 1.26 comments per 1000 views.',
              'High Indian follower base - This creator has about 85.73% follower base from India.',
            ],
            channelUrl: 'https://www.youtube.com/mralextech',
          ),
          PlatformStats(
            platform: SocialPlatform.twitter,
            followers: 95000,
            engagementRate: 3.2,
            avgViews: 8000,
            handle: '@alexchentech',
            avgLikes: 3040,
            avgComments: 198,
            avgShares: 425,
            totalPosts: 5620,
            estimatedReach: 66500,
            qoruzScore: 7.8,
          ),
          PlatformStats(
            platform: SocialPlatform.instagram,
            followers: 128000,
            engagementRate: 3.9,
            avgViews: 18000,
            handle: '@mralextech',
            avgLikes: 4992,
            avgComments: 156,
            avgShares: 89,
            totalPosts: 645,
            estimatedReach: 89600,
            qoruzScore: 8.1,
          ),
          // PlatformStats(
          //   platform: SocialPlatform.facebook,
          //   followers: 62000,
          //   engagementRate: 2.8,
          //   avgViews: 9500,
          //   handle: 'alextechreviews',
          //   avgLikes: 1736,
          //   avgComments: 92,
          //   avgShares: 145,
          //   totalPosts: 423,
          //   estimatedReach: 43400,
          //   qoruzScore: 7.2,
          // ),
        ],
        bio:
            'Tech reviewer & gadget enthusiast. Honest reviews of the latest tech products.',
        location: 'San Francisco, CA',
        languages: ['English', 'Mandarin'],
        isVerified: true,
        brandCollaborations: [
          BrandCollaboration(
            id: 'samsung',
            name: 'samsung',
            imageUrl: 'https://logo.clearbit.com/samsung.com',
            handle: '@samsungindia',
            postCount: 101,
            category: BrandCategory.consumerElectronics,
          ),
          BrandCollaboration(
            id: 'flipkart',
            name: 'flipkart',
            imageUrl: 'https://logo.clearbit.com/flipkart.com',
            handle: '@flipkart',
            postCount: 52,
            category: BrandCategory.ecommerce,
          ),
          BrandCollaboration(
            id: 'oneplus',
            name: 'oneplus_india',
            imageUrl: 'https://logo.clearbit.com/oneplus.com',
            handle: '@oneplus_india',
            postCount: 51,
            category: BrandCategory.consumerElectronics,
          ),
          BrandCollaboration(
            id: 'realme',
            name: 'realmeindia',
            imageUrl: 'https://logo.clearbit.com/realme.com',
            handle: '@realmeindia',
            postCount: 43,
            category: BrandCategory.consumerElectronics,
          ),
        ],
        portfolioImages: [
          'https://picsum.photos/400/600?random=7',
          'https://picsum.photos/400/600?random=8',
          'https://picsum.photos/400/600?random=9',
          'https://picsum.photos/400/600?random=10',
        ],
        joinedDate: DateTime(2021, 6, 20),
        contentCategories: [
          ContentCategory(name: 'Tech Reviews', percentage: 58.3),
          ContentCategory(name: 'Unboxing', percentage: 22.5),
          ContentCategory(name: 'Tutorials', percentage: 14.7),
          ContentCategory(name: 'News', percentage: 4.5),
        ],
        audienceDemographics: AudienceDemographics(
          genderDistribution: {'Male': 78.2, 'Female': 21.3, 'Other': 0.5},
          ageDistribution: {
            '13-17': 12.8,
            '18-24': 38.5,
            '25-34': 32.7,
            '35-44': 12.3,
            '45+': 3.7,
          },
          topCities: [
            LocationData(name: 'San Francisco', percentage: 22.3),
            LocationData(name: 'Seattle', percentage: 14.5),
            LocationData(name: 'Austin', percentage: 11.2),
          ],
          topStates: [
            LocationData(name: 'California', percentage: 35.8),
            LocationData(name: 'Washington', percentage: 16.5),
            LocationData(name: 'Texas', percentage: 13.2),
          ],
          topCountries: [
            LocationData(name: 'United States', percentage: 62.5),
            LocationData(name: 'India', percentage: 15.8),
            LocationData(name: 'United Kingdom', percentage: 9.2),
          ],
          audienceCredibility: 96.8,
        ),
        hashtags: [
          '#tech',
          '#technology',
          '#gadgets',
          '#techreview',
          '#smartphone',
          '#innovation',
          '#techtok',
          '#techie',
        ],
        videos: [
          Video(
            id: '1',
            title: 'iPhone 15 Pro Max Review',
            thumbnailUrl: 'https://picsum.photos/400/300?random=101',
            views: 9300000,
            likes: 525300,
            comments: 38400,
            uploadDate: DateTime.now().subtract(const Duration(days: 5)),
            type: VideoType.video,
          ),
          Video(
            id: '2',
            title: 'Samsung Galaxy S24 Ultra Unboxing',
            thumbnailUrl: 'https://picsum.photos/400/300?random=102',
            views: 4700000,
            likes: 455100,
            comments: 25800,
            uploadDate: DateTime.now().subtract(const Duration(days: 12)),
            type: VideoType.video,
          ),
          Video(
            id: '3',
            title: 'Top 5 Gadgets of 2024',
            thumbnailUrl: 'https://picsum.photos/400/300?random=103',
            views: 5400000,
            likes: 422800,
            comments: 11900,
            uploadDate: DateTime.now().subtract(const Duration(days: 18)),
            type: VideoType.video,
          ),
          Video(
            id: '4',
            title: 'Quick Tips: Best Camera Settings',
            thumbnailUrl: 'https://picsum.photos/400/300?random=104',
            views: 3500000,
            likes: 391800,
            comments: 15200,
            uploadDate: DateTime.now().subtract(const Duration(days: 3)),
            type: VideoType.short,
          ),
          Video(
            id: '5',
            title: 'Quick Tips: Best Camera Settings',
            thumbnailUrl: 'https://picsum.photos/400/300?random=104',
            views: 3500000,
            likes: 391800,
            comments: 15200,
            uploadDate: DateTime.now().subtract(const Duration(days: 3)),
            type: VideoType.short,
          ),
        ],
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
            avgLikes: 21760,
            avgComments: 892,
            avgShares: 445,
            totalPosts: 1856,
            estimatedReach: 224000,
            qoruzScore: 9.5,
          ),
          PlatformStats(
            platform: SocialPlatform.youtube,
            followers: 180000,
            engagementRate: 5.5,
            avgViews: 35000,
            handle: '@emmamakeup',
            avgLikes: 1925,
            avgComments: 267,
            avgShares: 189,
            totalPosts: 342,
            estimatedReach: 126000,
            qoruzScore: 8.9,
          ),
          PlatformStats(
            platform: SocialPlatform.facebook,
            followers: 145000,
            engagementRate: 4.2,
            avgViews: 22000,
            handle: 'emmabeautyofficial',
            avgLikes: 6090,
            avgComments: 234,
            avgShares: 378,
            totalPosts: 1124,
            estimatedReach: 101500,
            qoruzScore: 8.3,
          ),
          PlatformStats(
            platform: SocialPlatform.twitter,
            followers: 78000,
            engagementRate: 3.1,
            avgViews: 11000,
            handle: '@emmabeauty',
            avgLikes: 2418,
            avgComments: 145,
            avgShares: 267,
            totalPosts: 2890,
            estimatedReach: 54600,
            qoruzScore: 7.4,
          ),
        ],
        bio:
            'Professional makeup artist. Tutorials, reviews, and beauty tips for all skin types.',
        location: 'Miami, FL',
        languages: ['English', 'Spanish', 'Portuguese'],
        isVerified: true,
        brandCollaborations: [
          BrandCollaboration(
            id: 'sephora',
            name: 'Sephora',
            imageUrl: 'https://logo.clearbit.com/sephora.com',
            handle: '@sephora',
            postCount: 68,
            category: BrandCategory.other,
          ),
          BrandCollaboration(
            id: 'mac',
            name: 'MAC',
            imageUrl: 'https://logo.clearbit.com/maccosmetics.com',
            handle: '@maccosmetics',
            postCount: 52,
            category: BrandCategory.other,
          ),
          BrandCollaboration(
            id: 'fenty',
            name: 'Fenty Beauty',
            imageUrl: 'https://logo.clearbit.com/fentybeauty.com',
            handle: '@fentybeauty',
            postCount: 45,
            category: BrandCategory.other,
          ),
          BrandCollaboration(
            id: 'maybelline',
            name: 'Maybelline',
            imageUrl: 'https://logo.clearbit.com/maybelline.com',
            handle: '@maybelline',
            postCount: 38,
            category: BrandCategory.other,
          ),
        ],
        portfolioImages: [
          'https://picsum.photos/400/600?random=11',
          'https://picsum.photos/400/600?random=12',
          'https://picsum.photos/400/600?random=13',
          'https://picsum.photos/400/600?random=14',
          'https://picsum.photos/400/600?random=15',
        ],
        joinedDate: DateTime(2020, 9, 10),
        contentCategories: [
          ContentCategory(name: 'Makeup Tutorials', percentage: 52.8),
          ContentCategory(name: 'Product Reviews', percentage: 28.5),
          ContentCategory(name: 'Skincare', percentage: 13.2),
          ContentCategory(name: 'Beauty Tips', percentage: 5.5),
        ],
        audienceDemographics: AudienceDemographics(
          genderDistribution: {'Female': 89.5, 'Male': 10.2, 'Other': 0.3},
          ageDistribution: {
            '13-17': 15.2,
            '18-24': 45.8,
            '25-34': 27.5,
            '35-44': 9.2,
            '45+': 2.3,
          },
          topCities: [
            LocationData(name: 'Miami', percentage: 16.8),
            LocationData(name: 'Los Angeles', percentage: 14.2),
            LocationData(name: 'Houston', percentage: 10.5),
          ],
          topStates: [
            LocationData(name: 'Florida', percentage: 24.5),
            LocationData(name: 'California', percentage: 22.8),
            LocationData(name: 'Texas', percentage: 15.2),
          ],
          topCountries: [
            LocationData(name: 'United States', percentage: 58.5),
            LocationData(name: 'Brazil', percentage: 18.2),
            LocationData(name: 'Mexico', percentage: 12.8),
          ],
          audienceCredibility: 95.7,
        ),
        hashtags: [
          '#makeup',
          '#beauty',
          '#makeuptutorial',
          '#beautyblogger',
          '#makeupartist',
          '#skincare',
          '#beautytips',
          '#makeuplover',
        ],
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
            platform: SocialPlatform.youtube,
            followers: 156000,
            engagementRate: 6.8,
            avgViews: 45000,
            handle: '@davidfitpro',
          ),
          PlatformStats(
            platform: SocialPlatform.twitter,
            followers: 98000,
            engagementRate: 4.2,
            avgViews: 12000,
            handle: '@davidfitness',
          ),
          PlatformStats(
            platform: SocialPlatform.facebook,
            followers: 185000,
            engagementRate: 5.5,
            avgViews: 28000,
            handle: 'davidfitness',
          ),
        ],
        bio:
            'Certified personal trainer. Daily workout routines and nutrition tips.',
        location: 'New York, NY',
        languages: ['English', 'Korean'],
        isVerified: true,
        brandCollaborations: [
          BrandCollaboration(
            id: 'nike',
            name: 'Nike',
            imageUrl: 'https://logo.clearbit.com/nike.com',
            handle: '@nike',
            postCount: 62,
            category: BrandCategory.sports,
          ),
          BrandCollaboration(
            id: 'gymshark',
            name: 'GymShark',
            imageUrl: 'https://logo.clearbit.com/gymshark.com',
            handle: '@gymshark',
            postCount: 48,
            category: BrandCategory.sports,
          ),
          BrandCollaboration(
            id: 'myprotein',
            name: 'MyProtein',
            imageUrl: 'https://logo.clearbit.com/myprotein.com',
            handle: '@myprotein',
            postCount: 35,
            category: BrandCategory.sports,
          ),
          BrandCollaboration(
            id: 'lululemon',
            name: 'Lululemon',
            imageUrl: 'https://logo.clearbit.com/lululemon.com',
            handle: '@lululemon',
            postCount: 28,
            category: BrandCategory.sports,
          ),
        ],
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
        brandCollaborations: [
          BrandCollaboration(
            id: 'hellofresh',
            name: 'HelloFresh',
            imageUrl: 'https://logo.clearbit.com/hellofresh.com',
            handle: '@hellofresh',
            postCount: 42,
            category: BrandCategory.ecommerce,
          ),
          BrandCollaboration(
            id: 'kitchenaid',
            name: 'KitchenAid',
            imageUrl: 'https://logo.clearbit.com/kitchenaid.com',
            handle: '@kitchenaid',
            postCount: 31,
            category: BrandCategory.consumerElectronics,
          ),
          BrandCollaboration(
            id: 'blueapron',
            name: 'Blue Apron',
            imageUrl: 'https://logo.clearbit.com/blueapron.com',
            handle: '@blueapron',
            postCount: 29,
            category: BrandCategory.ecommerce,
          ),
        ],
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
          BrandCollaboration(
            id: 'gopro',
            name: 'GoPro',
            imageUrl: 'https://logo.clearbit.com/gopro.com',
            handle: '@gopro',
            postCount: 50,
            category: BrandCategory.technology,
          ),

          BrandCollaboration(
            id: 'airbnb',
            name: 'Airbnb',
            imageUrl: 'https://logo.clearbit.com/airbnb.com',
            handle: '@airbnb',
            postCount: 45,
            category: BrandCategory.travel,
          ),

          BrandCollaboration(
            id: 'thenorthface',
            name: 'The North Face',
            imageUrl: 'https://logo.clearbit.com/thenorthface.com',
            handle: '@thenorthface',
            postCount: 31,
            category: BrandCategory.other,
          ),

          BrandCollaboration(
            id: 'booking',
            name: 'Booking.com',
            imageUrl: 'https://logo.clearbit.com/booking.com',
            handle: '@booking',
            postCount: 27,
            category: BrandCategory.travel,
          ),
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
  static List<InfluencerModel> filterByCategory(InfluencerCategory? category) {
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
        .where(
          (i) =>
              i.name.toLowerCase().contains(lowerQuery) ||
              i.bio.toLowerCase().contains(lowerQuery) ||
              i.category.displayName.toLowerCase().contains(lowerQuery),
        )
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
        description: 'Promote our new summer collection with lifestyle content',
        type: CampaignType.sponsoredPost,
        status: CampaignStatus.active,
        budget: 5000,
        startDate: DateTime.now().subtract(const Duration(days: 5)),
        endDate: DateTime.now().add(const Duration(days: 25)),
        targetPlatforms: [SocialPlatform.instagram, SocialPlatform.youtube],
        contentRequirements:
            '3 Instagram posts, 5 stories, 2 YouTube shorts featuring our summer collection',
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
