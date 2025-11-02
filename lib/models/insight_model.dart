/// Insight type enum for categorizing insights
enum InsightType { positive, negative, warning }

/// Extension for InsightType to provide string representation
extension InsightTypeExtension on InsightType {
  String get value {
    switch (this) {
      case InsightType.positive:
        return 'positive';
      case InsightType.negative:
        return 'negative';
      case InsightType.warning:
        return 'warning';
    }
  }

  static InsightType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'positive':
        return InsightType.positive;
      case 'negative':
        return InsightType.negative;
      case 'warning':
        return InsightType.warning;
      default:
        return InsightType.positive;
    }
  }
}

/// Insight model for platform analytics
class Insight {
  final InsightType type;
  final String title;
  final String subtitle;

  Insight({
    required this.type,
    required this.title,
    required this.subtitle,
  });

  factory Insight.fromJson(Map<String, dynamic> json) {
    return Insight(
      type: InsightTypeExtension.fromString(json['type'] ?? 'positive'),
      title: json['title'],
      subtitle: json['subtitle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.value,
      'title': title,
      'subtitle': subtitle,
    };
  }
}
