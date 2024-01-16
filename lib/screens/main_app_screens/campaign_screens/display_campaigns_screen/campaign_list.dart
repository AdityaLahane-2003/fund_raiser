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
import '../single_campaign_details/donar_Screens/only_campaign_details.dart';

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
  bool isFilterVisible = false;
  bool isCurrentUserCampaign=false;
  bool isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    campaignProvider = Provider.of<CampaignProvider>(context, listen: false);
    currentUser = FirebaseAuth.instance.currentUser;
    isUserLoggedIn = currentUser != null;
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

  String selectedCategory = '';
  String selectedRelation = '';
  String selectedStatus = '';

  void _applyFilters(String category, String relation, String status) {
    campaignProvider.applyFilters(category, relation, status);
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
            onPressed: () {
              setState(() {
                isFilterVisible = !isFilterVisible;
              });
            },
            icon: const Icon(Icons.filter_alt),
          ),
        ],
      ),
      body: Consumer<CampaignProvider>(
        builder: (context, provider, child) {
          final campaigns = provider.filteredCampaigns == null
              ? provider.new_campaigns
              : provider.filteredCampaigns!;

          return  SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Campaigns: ${campaigns.length}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                          visible: isFilterVisible,
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text('Clear Filters',
                                    style: TextStyle(color: Colors.red)),
                                onTap: () {
                                  selectedStatus = '';
                                  selectedRelation = '';
                                  selectedCategory = '';
                                  _applyFilters('', '', '');
                                  setState(() {
                                    isFilterVisible = !isFilterVisible;
                                  });
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
                                      tileColor: selectedCategory == 'Medical'
                                          ? greenColor
                                          : Colors.grey[200],
                                      leading: const Icon(Icons.medical_services),
                                      title: const Text(
                                        'Medical',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          if (selectedCategory == 'Medical') {
                                            selectedCategory = '';
                                          } else{
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
                                          if (selectedCategory == 'Education') {
                                            selectedCategory = '';
                                          } else{
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
                                          if (selectedCategory == 'Memorial') {
                                            selectedCategory = '';
                                          } else{
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
                                          if (selectedCategory == 'Others') {
                                            selectedCategory = '';
                                          } else {
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
                                          if (selectedRelation == 'Myself') {
                                            selectedRelation = '';
                                          } else {
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
                                          if (selectedRelation == 'My Family') {
                                            selectedRelation = '';
                                          } else{
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
                                          if (selectedRelation == 'My Friend') {
                                            selectedRelation = '';
                                          } else {
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
                                          if (selectedRelation == 'Other') {
                                            selectedRelation = '';
                                          } else {
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
                                          ? greenColor
                                          : Colors.grey[200],
                                      leading: const Icon(Icons.arrow_forward_ios),
                                      title: const Text(
                                        'Urgent Need of Funds',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          if (selectedStatus == 'Urgent Need of Funds') {
                                            selectedStatus = '';
                                          } else{
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
                                          if (selectedStatus == 'Needs funds for the near future') {
                                            selectedStatus = '';
                                          } else{
                                            selectedStatus = 'Needs funds for the near future';
                                          }
                                        });
                                      },
                                    ),
                                    ListTile(
                                      tileColor:
                                      selectedStatus == 'Need funds for the upcoming event'
                                          ? greenColor
                                          : Colors.grey[200],
                                      leading: const Icon(Icons.arrow_forward_ios),
                                      title: const Text(
                                        'Need funds for the upcoming event',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          if (selectedStatus ==
                                              'Need funds for the upcoming event') {
                                            selectedStatus = '';
                                          } else{
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
                                  setState(() {
                                    isFilterVisible = !isFilterVisible;
                                  });
                                },
                                title: 'Apply Filters',
                                color: secondColor,
                              ),
                              const SizedBox(height: 10),
                            ],
                          )
                      ),
                      Column(
                        children: [
                          Visibility(
                            visible:selectedCategory!='',
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:15.0),
                                  child: Text('Category: '+selectedCategory),
                                ),
                                IconButton(
                                  iconSize: 20,
                                  onPressed: () {
                                    setState(() {
                                      selectedCategory = '';
                                      _applyFilters(selectedCategory, selectedRelation, selectedStatus);
                                    });
                                  },
                                  icon: const Icon(Icons.close),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible:selectedRelation!='',
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:15.0),
                                  child: Text('Relation: '+selectedRelation),
                                ),
                                IconButton(
                                  iconSize: 20,
                                  onPressed: () {
                                    setState(() {
                                      selectedRelation = '';
                                      _applyFilters(selectedCategory, selectedRelation, selectedStatus);
                                    });
                                  },
                                  icon: const Icon(Icons.close),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible:selectedStatus!='',
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:15.0),
                                  child: Text('Status: '+selectedStatus),
                                ),
                                IconButton(
                                  iconSize: 20,
                                  onPressed: () {
                                    setState(() {
                                      selectedStatus = '';
                                      _applyFilters(selectedCategory, selectedRelation, selectedStatus);
                                    });
                                  },
                                  icon: const Icon(Icons.close),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child:campaigns.isEmpty
                            ? const Center(
                          child: Text("No Campaigns right now."),
                        )
                            :isUserLoggedIn?  ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: campaigns.length,
                          itemBuilder: (context, index) {
                            Campaign campaign = campaigns[index];
                            if (isUserLoggedIn == false) {
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
                                      actionsAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      actions: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.grey[400],
                                          ),
                                          onPressed: () {
                                            Navigator.pop(
                                                context); // Close the dialog
                                          },
                                          child: const Text("Cancel",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await DeleteCampaignServices
                                                .deleteCampaign(campaign.id);
                                            await _loadCampaigns();
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          child: const Text("Delete",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ):ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: campaigns.length,
                          itemBuilder: (context, index) {
                            Campaign campaign = campaigns[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(campaign.coverPhoto),
                              ),
                              title: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: campaign.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    campaign.dateEnd
                                        .difference(DateTime.now())
                                        .inDays>=0?TextSpan(
                                      text:"\n" + campaign.dateEnd
                                          .difference(DateTime.now())
                                          .inDays
                                          .toString() + " days left",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.red,
                                      ),
                                    ):TextSpan(
                                      text:"\n" + "Campaign Expired",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),

                              ),
                              subtitle: Text(campaign.status,
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: secondColor)),
                              trailing:const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OnlyCampaignDetailsPage(
                                      campaign: campaign,),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
