import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Image.asset(
            "assets/logo.png",
            height: 100,
            width: 100,
          ),
          SizedBox(height: MediaQuery.of(context).size.height/20,),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(
                "https://firebasestorage.googleapis.com/v0/b/taarn-690cb.appspot.com/o/images%2FDonation_Successful_screen.jpeg-removebg-preview.png?alt=media&token=89768ad1-8185-4b14-b098-5a3d877de1d7"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height/20,),
          Align(
            alignment: Alignment.center,
            child:  Text(
              "Create and Manage \n Fundraising Campaigns",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
