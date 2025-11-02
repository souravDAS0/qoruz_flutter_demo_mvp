/// Audience demographics model for influencer audience analysis
class AudienceDemographics {
  final Map<String, double> genderDistribution;
  final Map<String, double> ageDistribution;
  final List<LocationData> topCities;
  final List<LocationData> topStates;
  final List<LocationData> topCountries;
  final double? audienceCredibility;

  AudienceDemographics({
    required this.genderDistribution,
    required this.ageDistribution,
    required this.topCities,
    required this.topStates,
    required this.topCountries,
    this.audienceCredibility,
  });

  factory AudienceDemographics.fromJson(Map<String, dynamic> json) {
    return AudienceDemographics(
      genderDistribution: Map<String, double>.from(
        json['genderDistribution'].map((k, v) => MapEntry(k, v.toDouble())),
      ),
      ageDistribution: Map<String, double>.from(
        json['ageDistribution'].map((k, v) => MapEntry(k, v.toDouble())),
      ),
      topCities: (json['topCities'] as List)
          .map((city) => LocationData.fromJson(city))
          .toList(),
      topStates: (json['topStates'] as List)
          .map((state) => LocationData.fromJson(state))
          .toList(),
      topCountries: (json['topCountries'] as List)
          .map((country) => LocationData.fromJson(country))
          .toList(),
      audienceCredibility: json['audienceCredibility']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'genderDistribution': genderDistribution,
      'ageDistribution': ageDistribution,
      'topCities': topCities.map((city) => city.toJson()).toList(),
      'topStates': topStates.map((state) => state.toJson()).toList(),
      'topCountries': topCountries.map((country) => country.toJson()).toList(),
      'audienceCredibility': audienceCredibility,
    };
  }

  String? get formattedCredibility {
    if (audienceCredibility == null) return null;
    return '${audienceCredibility!.toStringAsFixed(1)}%';
  }
}

/// Location data for demographics
class LocationData {
  final String name;
  final double percentage;

  LocationData({
    required this.name,
    required this.percentage,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      name: json['name'],
      percentage: json['percentage'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'percentage': percentage,
    };
  }

  String get formattedPercentage => '${percentage.toStringAsFixed(1)}%';
}
