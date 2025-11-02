import 'social_platform.dart';
import 'content_category.dart';
import 'audience_demographics.dart';
import 'video_model.dart';
import 'brand_collaboration.dart';

/// Influencer category enum
enum InfluencerCategory {
  fashion,
  tech,
  beauty,
  lifestyle,
  food,
  fitness,
  travel,
  gaming,
  education,
  entertainment,
}

/// Extension for category display
extension InfluencerCategoryExtension on InfluencerCategory {
  String get displayName {
    switch (this) {
      case InfluencerCategory.fashion:
        return 'Fashion';
      case InfluencerCategory.tech:
        return 'Tech';
      case InfluencerCategory.beauty:
        return 'Beauty';
      case InfluencerCategory.lifestyle:
        return 'Lifestyle';
      case InfluencerCategory.food:
        return 'Food';
      case InfluencerCategory.fitness:
        return 'Fitness';
      case InfluencerCategory.travel:
        return 'Travel';
      case InfluencerCategory.gaming:
        return 'Gaming';
      case InfluencerCategory.education:
        return 'Education';
      case InfluencerCategory.entertainment:
        return 'Entertainment';
    }
  }
}

/// Influencer model
class InfluencerModel {
  final String id;
  final String name;
  final String profileImage;
  final InfluencerCategory category;
  final List<PlatformStats> platforms;
  final String bio;
  final String? location;
  final List<String> languages;
  final bool isVerified;
  final List<BrandCollaboration> brandCollaborations;
  final List<String> portfolioImages;
  final DateTime joinedDate;
  final List<ContentCategory> contentCategories;
  final AudienceDemographics? audienceDemographics;
  final List<String> hashtags;
  final List<Video> videos;

  InfluencerModel({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.category,
    required this.platforms,
    required this.bio,
    this.location,
    required this.languages,
    this.isVerified = false,
    required this.brandCollaborations,
    required this.portfolioImages,
    required this.joinedDate,
    this.contentCategories = const [],
    this.audienceDemographics,
    this.hashtags = const [],
    this.videos = const [],
  });

  factory InfluencerModel.fromJson(Map<String, dynamic> json) {
    return InfluencerModel(
      id: json['id'],
      name: json['name'],
      profileImage: json['profileImage'],
      category: InfluencerCategory.values.firstWhere(
        (e) => e.toString() == 'InfluencerCategory.${json['category']}',
      ),
      platforms: (json['platforms'] as List)
          .map((p) => PlatformStats.fromJson(p))
          .toList(),
      bio: json['bio'],
      location: json['location'],
      languages: List<String>.from(json['languages']),
      isVerified: json['isVerified'] ?? false,
      brandCollaborations: json['brandCollaborations'] != null
          ? (json['brandCollaborations'] as List)
              .map((b) => b is String
                  ? BrandCollaboration(
                      id: b,
                      name: b,
                      imageUrl: '',
                      handle: '@$b',
                      postCount: 0,
                      category: BrandCategory.other,
                    )
                  : BrandCollaboration.fromJson(b))
              .toList()
          : [],
      portfolioImages: List<String>.from(json['portfolioImages']),
      joinedDate: DateTime.parse(json['joinedDate']),
      contentCategories: json['contentCategories'] != null
          ? (json['contentCategories'] as List)
              .map((c) => ContentCategory.fromJson(c))
              .toList()
          : [],
      audienceDemographics: json['audienceDemographics'] != null
          ? AudienceDemographics.fromJson(json['audienceDemographics'])
          : null,
      hashtags: json['hashtags'] != null
          ? List<String>.from(json['hashtags'])
          : [],
      videos: json['videos'] != null
          ? (json['videos'] as List).map((v) => Video.fromJson(v)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profileImage': profileImage,
      'category': category.toString().split('.').last,
      'platforms': platforms.map((p) => p.toJson()).toList(),
      'bio': bio,
      'location': location,
      'languages': languages,
      'isVerified': isVerified,
      'brandCollaborations':
          brandCollaborations.map((b) => b.toJson()).toList(),
      'portfolioImages': portfolioImages,
      'joinedDate': joinedDate.toIso8601String(),
      'contentCategories': contentCategories.map((c) => c.toJson()).toList(),
      'audienceDemographics': audienceDemographics?.toJson(),
      'hashtags': hashtags,
      'videos': videos.map((v) => v.toJson()).toList(),
    };
  }

  // Get primary platform stats (highest followers)
  PlatformStats get primaryPlatform {
    return platforms.reduce((a, b) => a.followers > b.followers ? a : b);
  }

  // Get total followers across all platforms
  int get totalFollowers {
    return platforms.fold(0, (sum, platform) => sum + platform.followers);
  }

  // Get average engagement rate
  double get averageEngagement {
    if (platforms.isEmpty) return 0;
    final total = platforms.fold(0.0, (sum, p) => sum + p.engagementRate);
    return total / platforms.length;
  }
}
