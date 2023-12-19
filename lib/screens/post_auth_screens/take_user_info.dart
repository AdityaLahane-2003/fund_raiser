import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/screens/main_app_screens/home_dashboard.dart';
import '../../firebase_services/user_services/add_user_details_service.dart';

class TakeUserInfoScreen extends StatefulWidget {
  const TakeUserInfoScreen({super.key});

  @override
  State<TakeUserInfoScreen> createState() => _TakeUserInfoScreenState();
}


class _TakeUserInfoScreenState extends State<TakeUserInfoScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false ;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.verified_user),
        automaticallyImplyLeading:false,
        title: Text('User Details'),
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Take Image"),
              SizedBox(height: 16.0),
              Text("Update UI"),
              SizedBox(height: 16.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
              // Name TextField
                    TextFormField(
                      controller: nameController,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter Name';
                        }
                        return null ;
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),

                    // Age TextField
                    TextFormField(
                      controller: ageController,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter Age';
                        }
                        return null ;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),

                    // Phone TextField
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter Phone';
                        }
                        return null ;
                      },
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller:bioController,
                      keyboardType: TextInputType.text,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter Bio';
                        }
                        return null ;
                      },
                      decoration: InputDecoration(
                        labelText: 'Bio',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
              // Button to display entered values
              ElevatedButton(
                onPressed: () {
                  loading=true;
                  String userEmail = getCurrentUserEmail();
                  if(_formKey.currentState!.validate()){
                    addUserDetails(
                        nameController.text.trim()!= "" ? nameController.text.trim() : "User",
                        userEmail,
                        phoneController.text.trim()!= "" ? phoneController.text.trim() : "Not Provided",
                        int.parse(ageController.text.trim())!= "" ? int.parse(ageController.text.trim()) : 0,
                        bioController.text.trim()!= "" ? bioController.text.trim() : "Not Provided"
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeDashboard()));
                  }
                },
                child:Center(child: loading ? CircularProgressIndicator(strokeWidth: 3,color: Colors.black,) :
                Text('Save My Data', style: TextStyle(color: Colors.black),),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
