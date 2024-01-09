import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/firebase_services/campaign_services/delete_campaign_services.dart';
import 'package:fund_raiser_second/screens/main_app_screens/campaign_screens/update_campaign.dart';
import 'package:fund_raiser_second/utils/constants/color_code.dart';
import 'package:provider/provider.dart';

import '../../../../components/button.dart';
import '../../../../components/campaign_card.dart';
import '../../../../firebase_services/campaign_services/search_campaign_services.dart';
import '../../../../models/campaign_model.dart';
import '../../../../providers/campaigns_provider.dart';

class CampaignsList extends StatefulWidget {
  const CampaignsList({Key? key}) : super(key: key);

  @override
  _CampaignsListState createState() => _CampaignsListState();
}

class _CampaignsListState extends State<CampaignsList> {
  late CampaignProvider campaignProvider;
  late User? currentUser;
  late TextEditingController searchController;
  bool isCategoryVisible = false;
  bool isRelationVisible = false;
  bool isStatusVisible = false;

  @override
  void initState() {
    super.initState();
    campaignProvider = Provider.of<CampaignProvider>(context, listen: false);
    currentUser = FirebaseAuth.instance.currentUser;
    searchController = TextEditingController();
    _loadCampaigns();
  }

  @override
  void dispose() {
    searchController.dispose();
    _applyFilters('', '', '');
    super.dispose();
  }

  Future<void> _loadCampaigns() async {
    await campaignProvider.loadCampaigns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        title: const Text('Campaigns List'),
        actions: [
          // Search functionality
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CampaignSearchDelegate(campaignProvider),
              );
            },
          ),
          IconButton(
              icon: Icon(Icons.filter_alt),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return _buildFilterBottomSheet(context);
                  },
                );
              }),
        ],
      ),
      body: Consumer<CampaignProvider>(
        builder: (context, provider, child) {
          final campaigns = provider.filteredCampaigns == null
              ? provider.campaigns
              : provider.filteredCampaigns!;

          return campaigns.isEmpty
              ? const Center(
                  child: Text("No Campaigns right now."),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: campaigns.length,
                  itemBuilder: (context, index) {
                    Campaign campaign = campaigns[index];
                    bool isCurrentUserCampaign;
                    if (currentUser == null) {
                      isCurrentUserCampaign = false;
                    } else {
                      isCurrentUserCampaign =
                          campaign.ownerId == currentUser?.uid;
                    }

                    return CampaignCard(
                      campaign: campaign,
                      isCurrentUserCampaign: isCurrentUserCampaign,
                      onUpdatePressed: () {
                        // Navigate to the update campaign page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UpdateCampaignPage(campaign: campaign),
                          ),
                        ).then((_) {
                          _loadCampaigns();
                        });
                      },
                      onDeletePressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Delete Campaign !!!"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/logo.png',
                                    // Replace with your image asset
                                    height: 100,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Are you sure you want to delete your Campaign? This action is irreversible.",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              actionsAlignment: MainAxisAlignment.spaceBetween,
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.grey[400],
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context); // Close the dialog
                                  },
                                  child: const Text("Cancel",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await DeleteCampaignServices.deleteCampaign(
                                        campaign.id);
                                    await _loadCampaigns();
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  child: const Text("Delete",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                );
        },
      ),
    );
  }

  Widget _buildFilterBottomSheet(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: const Text('Clear Filters', style: TextStyle(color: Colors.red)),
            onTap: () {
              selectedStatus = '';
              selectedRelation = '';
              selectedCategory = '';
              _applyFilters('', '', '');
              Navigator.pop(context);
            },
          ),
          InkWell(
            onTap: () {
              setState(() {
                isCategoryVisible = !isCategoryVisible;
              });
            },
            child: ListTile(
              title: const Text('Category'),
              trailing: isCategoryVisible
                  ? const Icon(Icons.arrow_drop_up)
                  : const Icon(Icons.arrow_drop_down),
            ),
          ),
          Visibility(
            visible: isCategoryVisible,
            child: Column(
              children: [
                ListTile(
                  tileColor:selectedCategory == 'Medical'
                      ? greenColor
                      : Colors.grey[200],
                  leading: const Icon(Icons.medical_services),
                  title: const Text(
                    'Medical',
                    style: TextStyle(fontSize: 15),
                  ),
                  onTap: () {
                    setState(() {
                      if(selectedCategory == 'Medical') {
                        selectedCategory = '';
                      } else if(selectedCategory == '') {
                        selectedCategory = 'Medical';
                      }
                    });
                  },
                ),
                ListTile(
                  tileColor: selectedCategory == 'Education'
                      ? greenColor
                      : Colors.grey[200],
                  leading: const Icon(Icons.school),
                  title: const Text(
                    'Education',
                    style: TextStyle(fontSize: 15),
                  ),
                  onTap: () {
                    setState(() {
                      if(selectedCategory == 'Education') {
                        selectedCategory = '';
                      } else if(selectedCategory == '') {
                        selectedCategory = 'Education';
                      }
                    });
                  },
                ),
                ListTile(
                  tileColor: selectedCategory == 'Memorial'
                      ? greenColor
                      : Colors.grey[200],
                  leading: const Icon(Icons.family_restroom),
                  title: const Text(
                    'Memorial',
                    style: TextStyle(fontSize: 15),
                  ),
                  onTap: () {
                    setState(() {
                      if(selectedCategory == 'Memorial') {
                        selectedCategory = '';
                      } else if(selectedCategory == '') {
                        selectedCategory = 'Memorial';
                      }
                    });
                  },
                ),
                ListTile(
                  tileColor: selectedCategory == 'Others'
                      ? greenColor
                      : Colors.grey[200],
                  leading: const Icon(Icons.sports),
                  title: const Text(
                    'Others',
                    style: TextStyle(fontSize: 15),
                  ),
                  onTap: () {
                    setState(() {
                      if(selectedCategory == 'Others') {
                        selectedCategory = '';
                      } else if(selectedCategory == '') {
                        selectedCategory = 'Others';
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                isRelationVisible = !isRelationVisible;
              });
            },
            child: ListTile(
              title: const Text('Relation'),
              trailing: isRelationVisible
                  ? const Icon(Icons.arrow_drop_up)
                  : const Icon(Icons.arrow_drop_down),
            ),
          ),
          Visibility(
            visible: isRelationVisible,
            child: Column(
              children: [
                ListTile(
                  tileColor: selectedRelation == 'Myself'
                      ? greenColor
                      : Colors.grey[200],
                  leading: const Icon(Icons.man),
                  title: const Text(
                    'Myself',
                    style: TextStyle(fontSize: 15),
                  ),
                  onTap: () {
                    setState(() {
                      if(selectedRelation == 'Myself') {
                        selectedRelation = '';
                      } else if(selectedRelation == '') {
                        selectedRelation = 'Myself';
                      }
                    });
                  },
                ),
                ListTile(
                  tileColor: selectedRelation == 'My Family'
                      ? greenColor
                      : Colors.grey[200],
                  leading: const Icon(Icons.family_restroom_sharp),
                  title: const Text(
                    'My Family',
                    style: TextStyle(fontSize: 15),
                  ),
                  onTap: () {
                    setState(() {
                      if(selectedRelation == 'My Family') {
                        selectedRelation = '';
                      } else if(selectedRelation == '') {
                        selectedRelation = 'My Family';
                      }
                    });
                  },
                ),
                ListTile(
                  tileColor: selectedRelation == 'My Friend'
                      ? greenColor
                      : Colors.grey[200],
                  leading: const Icon(Icons.person),
                  title: const Text(
                    'My Friend',
                    style: TextStyle(fontSize: 15),
                  ),
                  onTap: () {
                    setState(() {
                      if(selectedRelation == 'My Friend') {
                        selectedRelation = '';
                      } else if(selectedRelation == '') {
                        selectedRelation = 'My Friend';
                      }
                    });
                  },
                ),
                ListTile(
                  tileColor: selectedRelation == 'Other'
                      ? greenColor
                      : Colors.grey[200],
                  leading: const Icon(Icons.filter_none),
                  title: const Text(
                    'Other',
                    style: TextStyle(fontSize: 15),
                  ),
                  onTap: () {
                    setState(() {
                      if(selectedRelation == 'Other') {
                        selectedRelation = '';
                      } else if(selectedRelation == '') {
                        selectedRelation = 'Other';
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                isStatusVisible = !isStatusVisible;
              });
            },
            child: ListTile(
              title: const Text('Status'),
              trailing: isStatusVisible
                  ? const Icon(Icons.arrow_drop_up)
                  : const Icon(Icons.arrow_drop_down),
            ),
          ),
          Visibility(
            visible: isStatusVisible,
            child: Column(
              children: [
                ListTile(
                  tileColor: selectedStatus == 'Urgent Need of Funds'
                      ?  greenColor
                      : Colors.grey[200],
                  leading: const Icon(Icons.arrow_forward_ios),
                  title: const Text(
                    'Urgent Need of Funds',
                    style: TextStyle(fontSize: 15),
                  ),
                  onTap: () {
                    setState(() {
                      if(selectedStatus == 'Urgent Need of Funds') {
                        selectedStatus = '';
                      } else if(selectedStatus == '') {
                        selectedStatus = 'Urgent Need of Funds';
                      }
                    });
                  },
                ),
                ListTile(
                  tileColor: selectedStatus == 'Needs funds for the near future'
                      ? greenColor
                      : Colors.grey[200],
                  leading: const Icon(Icons.arrow_forward_ios),
                  title: const Text(
                    'Needs funds for the near future',
                    style: TextStyle(fontSize: 15),
                  ),
                  onTap: () {
                    setState(() {
                      if(selectedStatus == 'Needs funds for the near future') {
                        selectedStatus = '';
                      } else if(selectedStatus == '') {
                        selectedStatus = 'Needs funds for the near future';
                      }
                    });
                  },
                ),
                ListTile(
                  tileColor: selectedStatus == 'Need funds for the upcoming event'
                      ? greenColor
                      : Colors.grey[200],
                  leading: const Icon(Icons.arrow_forward_ios),
                  title: const Text(
                    'Need funds for the upcoming event',
                    style: TextStyle(fontSize: 15),
                  ),
                  onTap: () {
                    setState(() {
                      if(selectedStatus == 'Need funds for the upcoming event') {
                        selectedStatus = '';
                      } else if(selectedStatus == '') {
                        selectedStatus = 'Need funds for the upcoming event';
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
         Button(
            onTap: () {
              _applyFilters(
                selectedCategory,
                selectedRelation,
                selectedStatus,
              );
              Navigator.pop(context);
            },
            title: 'Apply Filters',
           color: secondColor,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

// Declare these variables to store the selected values
  String selectedCategory = '';
  String selectedRelation = '';
  String selectedStatus = '';

  void _applyFilters(String category, String relation, String status) {
    campaignProvider.applyFilters(category, relation, status);
  }
}
