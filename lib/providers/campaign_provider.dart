import 'package:flutter/foundation.dart';
import '../models/campaign_model.dart';
import '../services/mock_data_service.dart';

/// Campaign data provider
class CampaignProvider with ChangeNotifier {
  List<CampaignModel> _campaigns = [];
  CampaignStatus? _filterStatus;
  bool _isLoading = false;

  List<CampaignModel> get campaigns {
    if (_filterStatus == null) return _campaigns;
    return _campaigns.where((c) => c.status == _filterStatus).toList();
  }

  CampaignStatus? get filterStatus => _filterStatus;
  bool get isLoading => _isLoading;

  /// Load campaigns
  Future<void> loadCampaigns(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      _campaigns = MockDataService.getCampaigns(userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Filter by status
  void filterByStatus(CampaignStatus? status) {
    _filterStatus = status;
    notifyListeners();
  }

  /// Add new campaign
  Future<void> addCampaign(CampaignModel campaign) async {
    _campaigns.insert(0, campaign);
    notifyListeners();
  }

  /// Update campaign
  Future<void> updateCampaign(CampaignModel campaign) async {
    final index = _campaigns.indexWhere((c) => c.id == campaign.id);
    if (index != -1) {
      _campaigns[index] = campaign;
      notifyListeners();
    }
  }

  /// Delete campaign
  Future<void> deleteCampaign(String campaignId) async {
    _campaigns.removeWhere((c) => c.id == campaignId);
    notifyListeners();
  }

  /// Get campaign by ID
  CampaignModel? getCampaignById(String id) {
    try {
      return _campaigns.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }
}
