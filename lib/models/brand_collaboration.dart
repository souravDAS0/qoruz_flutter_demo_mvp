/// Brand collaboration category
enum BrandCategory {
  automotive,
  banking,
  consumerElectronics,
  ecommerce,
  entertainment,
  fashion,
  sports,
  technology,
  travel,
  other,
}

/// Extension for brand category display
extension BrandCategoryExtension on BrandCategory {
  String get displayName {
    switch (this) {
      case BrandCategory.automotive:
        return 'Automotive';
      case BrandCategory.banking:
        return 'Banking & Finance';
      case BrandCategory.consumerElectronics:
        return 'Consumer Electronics';
      case BrandCategory.ecommerce:
        return 'E-Commerce';
      case BrandCategory.entertainment:
        return 'Entertainment';
      case BrandCategory.fashion:
        return 'Fashion';
      case BrandCategory.sports:
        return 'Sports';
      case BrandCategory.technology:
        return 'Technology';
      case BrandCategory.travel:
        return 'Travel';
      case BrandCategory.other:
        return 'Other';
    }
  }
}

/// Brand collaboration model
class BrandCollaboration {
  final String id;
  final String name;
  final String imageUrl;
  final String handle;
  final int postCount;
  final BrandCategory category;

  BrandCollaboration({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.handle,
    required this.postCount,
    required this.category,
  });

  factory BrandCollaboration.fromJson(Map<String, dynamic> json) {
    return BrandCollaboration(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      handle: json['handle'],
      postCount: json['postCount'],
      category: BrandCategory.values.firstWhere(
        (e) => e.toString() == 'BrandCategory.${json['category']}',
        orElse: () => BrandCategory.other,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'handle': handle,
      'postCount': postCount,
      'category': category.toString().split('.').last,
    };
  }

  String get formattedPostCount {
    if (postCount >= 1000) {
      return '${(postCount / 1000).toStringAsFixed(0)}k';
    }
    return postCount.toString();
  }
}
