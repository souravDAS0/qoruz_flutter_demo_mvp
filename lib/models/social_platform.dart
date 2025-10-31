/// Social platform enum
enum SocialPlatform {
  instagram,
  youtube,
  tiktok,
  twitter,
}

/// Extension for social platform display
extension SocialPlatformExtension on SocialPlatform {
  String get displayName {
    switch (this) {
      case SocialPlatform.instagram:
        return 'Instagram';
      case SocialPlatform.youtube:
        return 'YouTube';
      case SocialPlatform.tiktok:
        return 'TikTok';
      case SocialPlatform.twitter:
        return 'Twitter';
    }
  }

  String get iconName {
    switch (this) {
      case SocialPlatform.instagram:
        return 'instagram';
      case SocialPlatform.youtube:
        return 'youtube';
      case SocialPlatform.tiktok:
        return 'tiktok';
      case SocialPlatform.twitter:
        return 'twitter';
    }
  }
}

/// Platform statistics model
class PlatformStats {
  final SocialPlatform platform;
  final int followers;
  final double engagementRate;
  final int avgViews;
  final String? handle;

  PlatformStats({
    required this.platform,
    required this.followers,
    required this.engagementRate,
    required this.avgViews,
    this.handle,
  });

  factory PlatformStats.fromJson(Map<String, dynamic> json) {
    return PlatformStats(
      platform: SocialPlatform.values.firstWhere(
        (e) => e.toString() == 'SocialPlatform.${json['platform']}',
      ),
      followers: json['followers'],
      engagementRate: json['engagementRate'].toDouble(),
      avgViews: json['avgViews'],
      handle: json['handle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'platform': platform.toString().split('.').last,
      'followers': followers,
      'engagementRate': engagementRate,
      'avgViews': avgViews,
      'handle': handle,
    };
  }

  String get formattedFollowers {
    if (followers >= 1000000) {
      return '${(followers / 1000000).toStringAsFixed(1)}M';
    } else if (followers >= 1000) {
      return '${(followers / 1000).toStringAsFixed(1)}K';
    }
    return followers.toString();
  }

  String get formattedEngagement {
    return '${engagementRate.toStringAsFixed(1)}%';
  }

  String get formattedAvgViews {
    if (avgViews >= 1000000) {
      return '${(avgViews / 1000000).toStringAsFixed(1)}M';
    } else if (avgViews >= 1000) {
      return '${(avgViews / 1000).toStringAsFixed(1)}K';
    }
    return avgViews.toString();
  }
}
