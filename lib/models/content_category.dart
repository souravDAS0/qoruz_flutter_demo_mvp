/// Content category model for influencer content analysis
class ContentCategory {
  final String name;
  final double percentage;
  final String? icon;

  ContentCategory({
    required this.name,
    required this.percentage,
    this.icon,
  });

  factory ContentCategory.fromJson(Map<String, dynamic> json) {
    return ContentCategory(
      name: json['name'],
      percentage: json['percentage'].toDouble(),
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'percentage': percentage,
      'icon': icon,
    };
  }

  String get formattedPercentage => '${percentage.toStringAsFixed(2)}%';
}
