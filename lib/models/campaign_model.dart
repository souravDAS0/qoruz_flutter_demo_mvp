import 'social_platform.dart';

/// Campaign type enum
enum CampaignType {
  productReview,
  sponsoredPost,
  brandAmbassador,
  contentCreation,
  eventCoverage,
  giveaway,
}

/// Extension for campaign type display
extension CampaignTypeExtension on CampaignType {
  String get displayName {
    switch (this) {
      case CampaignType.productReview:
        return 'Product Review';
      case CampaignType.sponsoredPost:
        return 'Sponsored Post';
      case CampaignType.brandAmbassador:
        return 'Brand Ambassador';
      case CampaignType.contentCreation:
        return 'Content Creation';
      case CampaignType.eventCoverage:
        return 'Event Coverage';
      case CampaignType.giveaway:
        return 'Giveaway';
    }
  }
}

/// Campaign status enum
enum CampaignStatus {
  draft,
  active,
  completed,
  cancelled,
}

/// Extension for campaign status display
extension CampaignStatusExtension on CampaignStatus {
  String get displayName {
    switch (this) {
      case CampaignStatus.draft:
        return 'Draft';
      case CampaignStatus.active:
        return 'Active';
      case CampaignStatus.completed:
        return 'Completed';
      case CampaignStatus.cancelled:
        return 'Cancelled';
    }
  }
}

/// Campaign model
class CampaignModel {
  final String id;
  final String name;
  final String description;
  final CampaignType type;
  final CampaignStatus status;
  final double budget;
  final DateTime startDate;
  final DateTime endDate;
  final List<SocialPlatform> targetPlatforms;
  final String contentRequirements;
  final List<String> selectedInfluencerIds;
  final String creatorId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  CampaignModel({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.status,
    required this.budget,
    required this.startDate,
    required this.endDate,
    required this.targetPlatforms,
    required this.contentRequirements,
    required this.selectedInfluencerIds,
    required this.creatorId,
    required this.createdAt,
    this.updatedAt,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: CampaignType.values.firstWhere(
        (e) => e.toString() == 'CampaignType.${json['type']}',
      ),
      status: CampaignStatus.values.firstWhere(
        (e) => e.toString() == 'CampaignStatus.${json['status']}',
      ),
      budget: json['budget'].toDouble(),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      targetPlatforms: (json['targetPlatforms'] as List)
          .map((p) => SocialPlatform.values.firstWhere(
                (e) => e.toString() == 'SocialPlatform.$p',
              ))
          .toList(),
      contentRequirements: json['contentRequirements'],
      selectedInfluencerIds: List<String>.from(json['selectedInfluencerIds']),
      creatorId: json['creatorId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
      'budget': budget,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'targetPlatforms':
          targetPlatforms.map((p) => p.toString().split('.').last).toList(),
      'contentRequirements': contentRequirements,
      'selectedInfluencerIds': selectedInfluencerIds,
      'creatorId': creatorId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  CampaignModel copyWith({
    String? id,
    String? name,
    String? description,
    CampaignType? type,
    CampaignStatus? status,
    double? budget,
    DateTime? startDate,
    DateTime? endDate,
    List<SocialPlatform>? targetPlatforms,
    String? contentRequirements,
    List<String>? selectedInfluencerIds,
    String? creatorId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CampaignModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      status: status ?? this.status,
      budget: budget ?? this.budget,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      targetPlatforms: targetPlatforms ?? this.targetPlatforms,
      contentRequirements: contentRequirements ?? this.contentRequirements,
      selectedInfluencerIds: selectedInfluencerIds ?? this.selectedInfluencerIds,
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Get campaign duration in days
  int get durationInDays {
    return endDate.difference(startDate).inDays;
  }

  // Check if campaign is ongoing
  bool get isOngoing {
    final now = DateTime.now();
    return status == CampaignStatus.active &&
        now.isAfter(startDate) &&
        now.isBefore(endDate);
  }

  // Get formatted budget
  String get formattedBudget {
    if (budget >= 100000) {
      return '\$${(budget / 1000).toStringAsFixed(0)}K';
    }
    return '\$${budget.toStringAsFixed(0)}';
  }
}
