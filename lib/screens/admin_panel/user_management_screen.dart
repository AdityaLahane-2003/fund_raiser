import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/campaign_model.dart';
import '../main_app_screens/campaign_screens/single_campaign_details/donar_Screens/only_campaign_details.dart';
import '../main_app_screens/drawers_option_screens/my_profile.dart';

class UserManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Management'),
      ),
      body: UserDataList(),
    );
  }
}

class UserDataList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final users = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return UserData(
            id: doc.id,
            email: data['email'],
            name: data['name'],
            bio: data['bio'],
            imageUrl: data['imageUrl'],
            age: int.parse(data['age'].toString()),
            campaigns: List<String>.from(data['campaigns'] ?? []),
            phone: (data['phone'].toString()),
          );
        }).toList();
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return UserListTile(user: user);
          },
        );
      },
    );
  }
}

class UserData {
  final String id;
  final String email;
  final String name;
  final String bio;
  final String imageUrl;
  final int age;
  final List<String> campaigns;
  final String phone;

  UserData({
    required this.id,
    required this.email,
    required this.name,
    this.bio = '',
    this.imageUrl = '',
    this.age = 0,
    this.campaigns = const [],
    this.phone = '',
  });
}

class UserListTile extends StatefulWidget {
  final UserData user;

  const UserListTile({required this.user});

  @override
  _UserListTileState createState() => _UserListTileState();
}

class _UserListTileState extends State<UserListTile> {
  bool _isExpanded = false;

  Future<List<DocumentSnapshot>> loadCampaigns(List<String> campaignIds) async{
    CollectionReference campaignsCollection =
    FirebaseFirestore.instance.collection('campaigns');
    QuerySnapshot campaignQuery = await campaignsCollection
        .where(FieldPath.documentId, whereIn: campaignIds)
        .get();

    return campaignQuery.docs;
  }
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.user.name),
      subtitle: Text(widget.user.email),
      leading: CircleAvatar(
        backgroundImage:widget.user.imageUrl==""? NetworkImage('https://firebasestorage.googleapis.com/v0/b/taarn-690cb.appspot.com/o/images%2Fuser_profile.png?alt=media&token=90feb39f-ef85-468b-9089-d8cf1f10d757'): NetworkImage(widget.user.imageUrl),
      ),
      trailing: IconButton(
        icon:_isExpanded? Icon(Icons.arrow_upward_sharp):Icon(Icons.arrow_downward_sharp),
        onPressed: () {
        },
      ),
      onExpansionChanged: (value) {
        setState(() {
          _isExpanded = value;
        });
      },
      children: [
        if (_isExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text("Edit User Info:"),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserInfoPage(userId:widget.user.id,),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Text('Age: ${widget.user.age}'),
                SizedBox(height: 3),
                Text('Phone: ${widget.user.phone}'),
                SizedBox(height: 3),
                Text('Bio: ${widget.user.bio}'),
                SizedBox(height: 3),
                Text('No. of Campaigns: ${widget.user.campaigns.length}'),
                SizedBox(height: 3),
                widget.user.campaigns.length==0?Container():
                FutureBuilder<List<DocumentSnapshot>>(
                  future: loadCampaigns(widget.user.campaigns),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.data!.isEmpty) {
                      return const Text('No campaigns yet.');
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('Campaigns:'),
                          SizedBox(height: 3),
                          for (var campaign in snapshot.data!)
                            ListTile(
                              title: Text(campaign['title']),
                              subtitle: Text("Days Left: ${campaign['dateEnd'].toDate().difference(DateTime.now()).inDays>0?campaign['dateEnd'].toDate().difference(DateTime.now()).inDays:'Expired'}",
                              style: TextStyle(color:campaign['dateEnd'].toDate().difference(DateTime.now()).inDays>0?Colors.green:Colors.red)),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(campaign['photoUrl']),
                              ),
                              trailing: IconButton(
                                icon: Icon(FontAwesomeIcons.eye),
                                onPressed: () {
                                  Campaign campaign2 = Campaign(
                                    id: campaign.id,
                                    title: campaign['title'],
                                    name: campaign['name'],
                                    description: campaign['description'],
                                    ownerId: campaign['ownerId'],
                                    category: campaign['category'],
                                    email: campaign['email'],
                                    relation: campaign['relation'],
                                    gender: campaign['gender'],
                                    age: campaign['age'],
                                    city: campaign['city'],
                                    schoolOrHospital: campaign['schoolOrHospital'],
                                    location: campaign['location'],
                                    coverPhoto: campaign['coverPhoto'],
                                    photoUrl: campaign['photoUrl'],
                                    amountRaised: campaign['amountRaised'],
                                    amountGoal: campaign['amountGoal'],
                                    amountDonors: campaign['amountDonors'],
                                    dateCreated: campaign['dateCreated'].toDate(),
                                    status: campaign['status'],
                                    dateEnd: campaign['dateEnd'].toDate(),
                                    tipAmount: campaign['tipAmount'],
                                    supporters: campaign['supporters'],
                                    documentUrls: List<String>.from(campaign['documentUrls']),
                                    mediaImageUrls: List<String>.from(campaign['mediaImageUrls']),
                                    mediaVideoUrls: List<String>.from(campaign['mediaVideoUrls']),
                                    updates: List<String>.from(campaign['updates']),
                                    donations: List<String>.from(campaign['donations']),
                                  );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OnlyCampaignDetailsPage(
                                        campaign: campaign2,),
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      );
                    }
                  },
                ),
                // Add more user details here as needed
              ],
            ),
          ),
      ],
    );
  }
}
