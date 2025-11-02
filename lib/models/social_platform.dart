import 'insight_model.dart';

/// Social platform enum
enum SocialPlatform { instagram, youtube, twitter, facebook }

/// Extension for social platform display
extension SocialPlatformExtension on SocialPlatform {
  String get displayName {
    switch (this) {
      case SocialPlatform.instagram:
        return 'Instagram';
      case SocialPlatform.youtube:
        return 'YouTube';
      case SocialPlatform.twitter:
        return 'Twitter';
      case SocialPlatform.facebook:
        return 'Facebook';
    }
  }

  String get iconName {
    switch (this) {
      case SocialPlatform.instagram:
        return 'insta';
      case SocialPlatform.youtube:
        return 'yt';
      case SocialPlatform.twitter:
        return 'x_twitter';
      case SocialPlatform.facebook:
        return 'fb';
    }
  }

  String get svgAssetPath {
    return 'assests/svg/$iconName.svg';
  }
}

/// Platform statistics model
class PlatformStats {
  final SocialPlatform platform;
  final int followers;
  final double engagementRate;
  final int avgViews;
  final String? handle;
  final int? avgLikes;
  final int? avgComments;
  final int? avgShares;
  final int? totalPosts;
  final int? estimatedReach;
  final double? qoruzScore;

  // YouTube-specific fields
  final int? subscribers; // YouTube subscriber count
  final int? totalVideos; // Total number of videos
  final int? totalShorts; // Total number of shorts
  final int? avgViewsVideos; // Average views for videos
  final int? avgViewsShorts; // Average views for shorts
  final int? avgViews7Days; // Average views in last 7 days
  final int? avgLikesVideos; // Average likes for videos
  final int? avgLikesShorts; // Average likes for shorts
  final int? avgCommentsVideos; // Average comments for videos
  final int? avgCommentsShorts; // Average comments for shorts
  final double? likesCommentsRatio; // Likes-to-comments ratio
  final double? recurringViewership; // Recurring viewership score
  final String? qoruzScoreRank; // e.g., "Top 2%", "Top 1%"
  final List<Insight>? insights; // List of insights
  final String? channelUrl; // YouTube channel URL

  PlatformStats({
    required this.platform,
    required this.followers,
    required this.engagementRate,
    required this.avgViews,
    this.handle,
    this.avgLikes,
    this.avgComments,
    this.avgShares,
    this.totalPosts,
    this.estimatedReach,
    this.qoruzScore,
    // YouTube-specific
    this.subscribers,
    this.totalVideos,
    this.totalShorts,
    this.avgViewsVideos,
    this.avgViewsShorts,
    this.avgViews7Days,
    this.avgLikesVideos,
    this.avgLikesShorts,
    this.avgCommentsVideos,
    this.avgCommentsShorts,
    this.likesCommentsRatio,
    this.recurringViewership,
    this.qoruzScoreRank,
    this.insights,
    this.channelUrl,
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
      avgLikes: json['avgLikes'],
      avgComments: json['avgComments'],
      avgShares: json['avgShares'],
      totalPosts: json['totalPosts'],
      estimatedReach: json['estimatedReach'],
      qoruzScore: json['qoruzScore']?.toDouble(),
      // YouTube-specific
      subscribers: json['subscribers'],
      totalVideos: json['totalVideos'],
      totalShorts: json['totalShorts'],
      avgViewsVideos: json['avgViewsVideos'],
      avgViewsShorts: json['avgViewsShorts'],
      avgViews7Days: json['avgViews7Days'],
      avgLikesVideos: json['avgLikesVideos'],
      avgLikesShorts: json['avgLikesShorts'],
      avgCommentsVideos: json['avgCommentsVideos'],
      avgCommentsShorts: json['avgCommentsShorts'],
      likesCommentsRatio: json['likesCommentsRatio']?.toDouble(),
      recurringViewership: json['recurringViewership']?.toDouble(),
      qoruzScoreRank: json['qoruzScoreRank'],
      insights: json['insights'] != null
          ? (json['insights'] as List)
              .map((i) => Insight.fromJson(i))
              .toList()
          : null,
      channelUrl: json['channelUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'platform': platform.toString().split('.').last,
      'followers': followers,
      'engagementRate': engagementRate,
      'avgViews': avgViews,
      'handle': handle,
      'avgLikes': avgLikes,
      'avgComments': avgComments,
      'avgShares': avgShares,
      'totalPosts': totalPosts,
      'estimatedReach': estimatedReach,
      'qoruzScore': qoruzScore,
      // YouTube-specific
      'subscribers': subscribers,
      'totalVideos': totalVideos,
      'totalShorts': totalShorts,
      'avgViewsVideos': avgViewsVideos,
      'avgViewsShorts': avgViewsShorts,
      'avgViews7Days': avgViews7Days,
      'avgLikesVideos': avgLikesVideos,
      'avgLikesShorts': avgLikesShorts,
      'avgCommentsVideos': avgCommentsVideos,
      'avgCommentsShorts': avgCommentsShorts,
      'likesCommentsRatio': likesCommentsRatio,
      'recurringViewership': recurringViewership,
      'qoruzScoreRank': qoruzScoreRank,
      'insights': insights?.map((i) => i.toJson()).toList(),
      'channelUrl': channelUrl,
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

  String? get formattedAvgLikes {
    if (avgLikes == null) return null;
    if (avgLikes! >= 1000000) {
      return '${(avgLikes! / 1000000).toStringAsFixed(1)}M';
    } else if (avgLikes! >= 1000) {
      return '${(avgLikes! / 1000).toStringAsFixed(1)}K';
    }
    return avgLikes.toString();
  }

  String? get formattedAvgComments {
    if (avgComments == null) return null;
    if (avgComments! >= 1000000) {
      return '${(avgComments! / 1000000).toStringAsFixed(1)}M';
    } else if (avgComments! >= 1000) {
      return '${(avgComments! / 1000).toStringAsFixed(1)}K';
    }
    return avgComments.toString();
  }

  String? get formattedAvgShares {
    if (avgShares == null) return null;
    if (avgShares! >= 1000000) {
      return '${(avgShares! / 1000000).toStringAsFixed(1)}M';
    } else if (avgShares! >= 1000) {
      return '${(avgShares! / 1000).toStringAsFixed(1)}K';
    }
    return avgShares.toString();
  }

  String? get formattedEstimatedReach {
    if (estimatedReach == null) return null;
    if (estimatedReach! >= 1000000) {
      return '${(estimatedReach! / 1000000).toStringAsFixed(1)}M';
    } else if (estimatedReach! >= 1000) {
      return '${(estimatedReach! / 1000).toStringAsFixed(1)}K';
    }
    return estimatedReach.toString();
  }

  String? get formattedQoruzScore {
    if (qoruzScore == null) return null;
    return qoruzScore!.toStringAsFixed(2);
  }

  // YouTube-specific formatting methods
  String? get formattedSubscribers {
    if (subscribers == null) return null;
    if (subscribers! >= 1000000) {
      return '${(subscribers! / 1000000).toStringAsFixed(1)}m';
    } else if (subscribers! >= 1000) {
      return '${(subscribers! / 1000).toStringAsFixed(1)}k';
    }
    return subscribers.toString();
  }

  String? get formattedTotalVideos {
    if (totalVideos == null) return null;
    if (totalVideos! >= 1000) {
      return '${(totalVideos! / 1000).toStringAsFixed(1)}k';
    }
    return totalVideos.toString();
  }

  String? get formattedAvgViewsVideos {
    if (avgViewsVideos == null) return null;
    if (avgViewsVideos! >= 1000000) {
      return '${(avgViewsVideos! / 1000000).toStringAsFixed(1)}m';
    } else if (avgViewsVideos! >= 1000) {
      return '${(avgViewsVideos! / 1000).toStringAsFixed(1)}k';
    }
    return avgViewsVideos.toString();
  }

  String? get formattedAvgViewsShorts {
    if (avgViewsShorts == null) return null;
    if (avgViewsShorts! >= 1000000) {
      return '${(avgViewsShorts! / 1000000).toStringAsFixed(1)}m';
    } else if (avgViewsShorts! >= 1000) {
      return '${(avgViewsShorts! / 1000).toStringAsFixed(1)}k';
    }
    return avgViewsShorts.toString();
  }

  String? get formattedAvgViews7Days {
    if (avgViews7Days == null) return null;
    if (avgViews7Days! >= 1000000) {
      return '${(avgViews7Days! / 1000000).toStringAsFixed(1)}m';
    } else if (avgViews7Days! >= 1000) {
      return '${(avgViews7Days! / 1000).toStringAsFixed(1)}k';
    }
    return avgViews7Days.toString();
  }

  String? get formattedAvgLikesVideos {
    if (avgLikesVideos == null) return null;
    if (avgLikesVideos! >= 1000000) {
      return '${(avgLikesVideos! / 1000000).toStringAsFixed(1)}m';
    } else if (avgLikesVideos! >= 1000) {
      return '${(avgLikesVideos! / 1000).toStringAsFixed(1)}k';
    }
    return avgLikesVideos.toString();
  }

  String? get formattedAvgLikesShorts {
    if (avgLikesShorts == null) return null;
    if (avgLikesShorts! >= 1000000) {
      return '${(avgLikesShorts! / 1000000).toStringAsFixed(1)}m';
    } else if (avgLikesShorts! >= 1000) {
      return '${(avgLikesShorts! / 1000).toStringAsFixed(1)}k';
    }
    return avgLikesShorts.toString();
  }

  String? get formattedAvgCommentsVideos {
    if (avgCommentsVideos == null) return null;
    if (avgCommentsVideos! >= 1000) {
      return '${(avgCommentsVideos! / 1000).toStringAsFixed(0)}k';
    }
    return avgCommentsVideos.toString();
  }

  String? get formattedAvgCommentsShorts {
    if (avgCommentsShorts == null) return null;
    if (avgCommentsShorts! >= 1000) {
      return '${(avgCommentsShorts! / 1000).toStringAsFixed(0)}k';
    }
    return avgCommentsShorts.toString();
  }

  String? get formattedLikesCommentsRatio {
    if (likesCommentsRatio == null) return null;
    return likesCommentsRatio!.toStringAsFixed(2);
  }

  String? get formattedRecurringViewership {
    if (recurringViewership == null) return null;
    return recurringViewership!.toStringAsFixed(2);
  }

  String? get likesCommentsRatioLabel {
    if (likesCommentsRatio == null) return null;
    if (likesCommentsRatio! >= 9.0) return 'Excellent';
    if (likesCommentsRatio! >= 7.0) return 'Very Good';
    if (likesCommentsRatio! >= 5.0) return 'Good';
    if (likesCommentsRatio! >= 3.0) return 'Average';
    return 'Below Average';
  }

  String? get recurringViewershipLabel {
    if (recurringViewership == null) return null;
    if (recurringViewership! >= 4.0) return 'Excellent';
    if (recurringViewership! >= 3.0) return 'Very Good';
    if (recurringViewership! >= 2.0) return 'Good';
    if (recurringViewership! >= 1.0) return 'Average';
    return 'Below Average';
  }
}
