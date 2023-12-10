import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/screens/auth_screens/email_auth/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fund_raiser_second/screens/main_app_screens/home_dashboard.dart';
import '../../utils/utils_toast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
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

    String getCurrentUserId() {
      User? user = FirebaseAuth.instance.currentUser;
      return user?.uid ?? '';
    } String getCurrentUserEmail() {
      User? user = FirebaseAuth.instance.currentUser;
      return user?.email ?? '';
    }
    Future addUserDetails(String name, String email, String phone, int age, String bio) async{
      String userId = getCurrentUserId();
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      await users.doc(userId).set({
        'name':name,
        'email':email,
        'phone':phone,
        'age':age,
        'bio':bio,
        'imageUrl': "",
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        automaticallyImplyLeading:false,
        title: Text('Post'),
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            }).onError((error, stackTrace){
              Utils().toastMessage(error.toString());
            });
          }, icon: Icon(Icons.logout_outlined),),
          SizedBox(width: 10,)
        ],
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
