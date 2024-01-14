import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fund_raiser_second/models/campaign_model.dart';

class CampaignProvider extends ChangeNotifier {
  late List<Campaign> campaigns = [];
  late List<Campaign> ending_campaigns = [];
  late List<Campaign> new_campaigns = [];
  late List<Campaign> _searchResults = [];
  List<Campaign>? _filteredCampaigns;
  List<Campaign>? get filteredCampaigns => _filteredCampaigns;
  List<Campaign> get searchResults => _searchResults;

  Future<void> loadCampaigns() async {
    final campaignsCollection = FirebaseFirestore.instance.collection(
        'campaigns');
    final snapshot = await campaignsCollection.orderBy('dateCreated',descending: true).get();


    campaigns = snapshot.docs.map((doc) {
      return Campaign(
        id: doc.id,
        name: doc['name'],
        title: doc['title'],
        description: doc['description'],
        ownerId: doc['ownerId'],
        category: doc['category'],
        email: doc['email'],
        relation: doc['relation'],
        photoUrl: doc['photoUrl'],
        gender: doc['gender'],
        age: doc['age'],
        city: doc['city'],
        schoolOrHospital: doc['schoolOrHospital'],
        location: doc['location'],
        coverPhoto: doc['coverPhoto'],
        amountRaised: doc['amountRaised'],
        amountGoal: doc['amountGoal'],
        amountDonors: doc['amountDonors'],
        dateCreated: doc['dateCreated'].toDate(),
        status: doc['status'],
        dateEnd: doc['dateEnd'].toDate(),
        tipAmount: doc['tipAmount'],
        supporters: doc['supporters'],
        documentUrls: List<String>.from(doc['documentUrls']),
        mediaImageUrls: List<String>.from(doc['mediaImageUrls']),
        mediaVideoUrls: List<String>.from(doc['mediaVideoUrls']),
        updates: List<String>.from(doc['updates']),
      );
    }).toList();
    new_campaigns = snapshot.docs.map((doc) {
      return Campaign(
        id: doc.id,
        name: doc['name'],
        title: doc['title'],
        description: doc['description'],
        ownerId: doc['ownerId'],
        category: doc['category'],
        email: doc['email'],
        relation: doc['relation'],
        photoUrl: doc['photoUrl'],
        gender: doc['gender'],
        age: doc['age'],
        city: doc['city'],
        schoolOrHospital: doc['schoolOrHospital'],
        location: doc['location'],
        coverPhoto: doc['coverPhoto'],
        amountRaised: doc['amountRaised'],
        amountGoal: doc['amountGoal'],
        amountDonors: doc['amountDonors'],
        dateCreated: doc['dateCreated'].toDate(),
        status: doc['status'],
        dateEnd: doc['dateEnd'].toDate(),
        tipAmount: doc['tipAmount'],
        supporters: doc['supporters'],
        documentUrls: List<String>.from(doc['documentUrls']),
        mediaImageUrls: List<String>.from(doc['mediaImageUrls']),
        mediaVideoUrls: List<String>.from(doc['mediaVideoUrls']),
        updates: List<String>.from(doc['updates']),
      );
    }).toList();;
    ending_campaigns = snapshot.docs.map((doc) {
      return Campaign(
        id: doc.id,
        name: doc['name'],
        title: doc['title'],
        description: doc['description'],
        ownerId: doc['ownerId'],
        category: doc['category'],
        email: doc['email'],
        relation: doc['relation'],
        photoUrl: doc['photoUrl'],
        gender: doc['gender'],
        age: doc['age'],
        city: doc['city'],
        schoolOrHospital: doc['schoolOrHospital'],
        location: doc['location'],
        coverPhoto: doc['coverPhoto'],
        amountRaised: doc['amountRaised'],
        amountGoal: doc['amountGoal'],
        amountDonors: doc['amountDonors'],
        dateCreated: doc['dateCreated'].toDate(),
        status: doc['status'],
        dateEnd: doc['dateEnd'].toDate(),
        tipAmount: doc['tipAmount'],
        supporters: doc['supporters'],
        documentUrls: List<String>.from(doc['documentUrls']),
        mediaImageUrls: List<String>.from(doc['mediaImageUrls']),
        mediaVideoUrls: List<String>.from(doc['mediaVideoUrls']),
        updates: List<String>.from(doc['updates']),
      );
    }).toList();;

    notifyListeners();
  }

  // Filter campaigns by category
  List<Campaign> filterByCategory(String category) {
    return campaigns.where((campaign) => campaign.category == category)
        .toList();
  }

  // Filter campaigns by relation
  List<Campaign> filterByRelation(String relation) {
    return campaigns.where((campaign) => campaign.relation == relation)
        .toList();
  }

  // Filter campaigns by status
  List<Campaign> filterByStatus(String status) {
    return campaigns.where((campaign) => campaign.status == status).toList();
  }
  void applyFilters(String category, String relation, String status) {
    _filteredCampaigns = campaigns;

    // Apply filters based on category, relation, and status
    if (category.isNotEmpty) {
      _filteredCampaigns = _filteredCampaigns
          ?.where((campaign) => campaign.category.toLowerCase() == category.toLowerCase())
          .toList();
    }

    if (relation.isNotEmpty) {
      _filteredCampaigns = _filteredCampaigns
          ?.where((campaign) => campaign.relation.toLowerCase() == relation.toLowerCase())
          .toList();
    }

    if (status.isNotEmpty) {
      _filteredCampaigns = _filteredCampaigns
          ?.where((campaign) => campaign.status.toLowerCase() == status.toLowerCase())
          .toList();
    }

    notifyListeners();
  }
  // Search campaigns by query
  void searchCampaigns(String query) {
    _searchResults = campaigns
        .where((campaign) =>
    campaign.name.toLowerCase().contains(query.toLowerCase()) ||
        campaign.title.toLowerCase().contains(query.toLowerCase()) ||
        // Add more fields to search if needed
        campaign.description.toLowerCase().contains(query.toLowerCase()))
        .toList();

    notifyListeners();
  }
}
