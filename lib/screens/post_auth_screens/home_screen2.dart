import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fund_raiser_second/screens/auth_screens/email_auth/login_screen.dart';
import 'package:fund_raiser_second/screens/main_app_screens/home_dashboard.dart';

import '../../utils/utils_toast.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:(context)=> HomeDashboard()));
            }, child: Text("HomeDashBoard")),
            Text('Home Screen 2'
            , style: TextStyle(fontSize: 50,color: Colors.deepOrange),),
            SizedBox(height: 10,),
            Text('Here list of Campaigns will be shown'),
            Icon(Icons.wifi_password_outlined,size: 100,)
          ],
        ),
      ),
    );
  }
}
