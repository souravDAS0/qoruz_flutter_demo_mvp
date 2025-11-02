/// Video content type
enum VideoType { video, short, reel, post }

/// Extension for video type display
extension VideoTypeExtension on VideoType {
  String get displayName {
    switch (this) {
      case VideoType.video:
        return 'Video';
      case VideoType.short:
        return 'Short';
      case VideoType.reel:
        return 'Reel';
      case VideoType.post:
        return 'Post';
    }
  }
}

/// Video model for influencer content
class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  final int views;
  final int likes;
  final int comments;
  final DateTime uploadDate;
  final VideoType type;
  final String? url;

  Video({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.views,
    required this.likes,
    required this.comments,
    required this.uploadDate,
    required this.type,
    this.url,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
      views: json['views'],
      likes: json['likes'],
      comments: json['comments'],
      uploadDate: DateTime.parse(json['uploadDate']),
      type: VideoType.values.firstWhere(
        (e) => e.toString() == 'VideoType.${json['type']}',
      ),
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnailUrl': thumbnailUrl,
      'views': views,
      'likes': likes,
      'comments': comments,
      'uploadDate': uploadDate.toIso8601String(),
      'type': type.toString().split('.').last,
      'url': url,
    };
  }

  String get formattedViews {
    if (views >= 1000000) {
      return '${(views / 1000000).toStringAsFixed(1)}M';
    } else if (views >= 1000) {
      return '${(views / 1000).toStringAsFixed(1)}K';
    }
    return views.toString();
  }

  String get formattedLikes {
    if (likes >= 1000000) {
      return '${(likes / 1000000).toStringAsFixed(1)}M';
    } else if (likes >= 1000) {
      return '${(likes / 1000).toStringAsFixed(1)}K';
    }
    return likes.toString();
  }

  String get formattedComments {
    if (comments >= 1000000) {
      return '${(comments / 1000000).toStringAsFixed(1)}M';
    } else if (comments >= 1000) {
      return '${(comments / 1000).toStringAsFixed(1)}K';
    }
    return comments.toString();
  }
}
