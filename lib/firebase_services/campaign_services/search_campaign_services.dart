
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/firebase_services/user_services/add_user_details_service.dart';

import '../../models/campaign_model.dart';
import '../../providers/campaigns_provider.dart';
import '../../screens/main_app_screens/campaign_screens/single_campaign_details/currentUser_Screens/single_campaign_home.dart';
import '../../screens/main_app_screens/campaign_screens/single_campaign_details/donar_Screens/only_campaign_details.dart';

class CampaignSearchDelegate extends SearchDelegate<String> {
  final CampaignProvider campaignProvider;
  final String userId;

  CampaignSearchDelegate(this.campaignProvider, this.userId);

  @override
  String get searchFieldLabel => 'Search Campaigns';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      // Clear search query
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left of the search bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show search results based on query
    campaignProvider.searchCampaigns(query);
    return _buildSearchResults(context,campaignProvider.searchResults);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions while typing

    if (query.trim().isEmpty) {
      // Return an empty container if the query is empty
      return Container();
    }

    // Filter suggestions based on the current query
    final suggestions = campaignProvider.searchResults
        .where((campaign) =>
    campaign.name.toLowerCase().contains(query.toLowerCase()) ||
        campaign.title.toLowerCase().contains(query.toLowerCase()) ||
        campaign.description.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildSearchResults(context, suggestions);
  }

  Widget _buildSearchResults(BuildContext context,List<Campaign> campaigns) {
    // final campaigns = campaignProvider.searchResults;
    if (campaigns.isEmpty) {
      return Center(
        child: Text("No results found."),
      );
    }

    return ListView.builder(
      itemCount: campaigns.length,
      itemBuilder: (context, index) {
        Campaign campaign = campaigns[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(campaign.photoUrl),
          ),
          trailing:Icon(Icons.arrow_forward_ios),
          subtitle: Text(campaign.status),
          title: Text(campaign.title + " - " + campaign.name),
          onTap: () {
            userId == campaign.ownerId
                ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SingleCampaignHomeScreen(
                  campaign: campaign,
                ),
              ),
            )
                :
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OnlyCampaignDetailsPage(campaign: campaign),
              ),
            );
          },
        );
      },
    );
  }
}

