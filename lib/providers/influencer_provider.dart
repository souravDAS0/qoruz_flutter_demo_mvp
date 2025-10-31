import 'package:flutter/foundation.dart';
import '../models/influencer_model.dart';
import '../models/social_platform.dart';
import '../services/mock_data_service.dart';

/// Influencer data provider
class InfluencerProvider with ChangeNotifier {
  List<InfluencerModel> _influencers = [];
  List<InfluencerModel> _filteredInfluencers = [];
  InfluencerCategory? _selectedCategory;
  SocialPlatform? _selectedPlatform;
  String _searchQuery = '';
  bool _isLoading = false;

  List<InfluencerModel> get influencers => _filteredInfluencers;
  InfluencerCategory? get selectedCategory => _selectedCategory;
  SocialPlatform? get selectedPlatform => _selectedPlatform;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;

  /// Load influencers
  Future<void> loadInfluencers() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      _influencers = MockDataService.getInfluencers();
      _filteredInfluencers = _influencers;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Filter by category
  void filterByCategory(InfluencerCategory? category) {
    _selectedCategory = category;
    _selectedPlatform = null; // Clear platform filter
    _applyFilters();
  }

  /// Filter by platform
  void filterByPlatform(SocialPlatform? platform) {
    _selectedPlatform = platform;
    _selectedCategory = null; // Clear category filter
    _applyFilters();
  }

  /// Search influencers
  void searchInfluencers(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  /// Clear all filters
  void clearFilters() {
    _selectedCategory = null;
    _selectedPlatform = null;
    _searchQuery = '';
    _filteredInfluencers = _influencers;
    notifyListeners();
  }

  /// Apply filters
  void _applyFilters() {
    List<InfluencerModel> results = _influencers;

    // Apply category filter
    if (_selectedCategory != null) {
      results = results.where((i) => i.category == _selectedCategory).toList();
    }

    // Apply platform filter
    if (_selectedPlatform != null) {
      results = results
          .where(
              (i) => i.platforms.any((p) => p.platform == _selectedPlatform))
          .toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      final lowerQuery = _searchQuery.toLowerCase();
      results = results
          .where((i) =>
              i.name.toLowerCase().contains(lowerQuery) ||
              i.bio.toLowerCase().contains(lowerQuery) ||
              i.category.displayName.toLowerCase().contains(lowerQuery))
          .toList();
    }

    _filteredInfluencers = results;
    notifyListeners();
  }

  /// Get influencer by ID
  InfluencerModel? getInfluencerById(String id) {
    try {
      return _influencers.firstWhere((i) => i.id == id);
    } catch (e) {
      return null;
    }
  }
}
