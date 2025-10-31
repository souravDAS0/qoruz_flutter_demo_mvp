import 'social_platform.dart';

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
  final List<String> brandCollaborations;
  final List<String> portfolioImages;
  final DateTime joinedDate;

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
      brandCollaborations: List<String>.from(json['brandCollaborations']),
      portfolioImages: List<String>.from(json['portfolioImages']),
      joinedDate: DateTime.parse(json['joinedDate']),
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
      'brandCollaborations': brandCollaborations,
      'portfolioImages': portfolioImages,
      'joinedDate': joinedDate.toIso8601String(),
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
