import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
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
              image: const DecorationImage(
                image: NetworkImage(
                 "https://firebasestorage.googleapis.com/v0/b/taarn-690cb.appspot.com/o/images%2FIntro_screen_two.jpeg-removebg-preview.png?alt=media&token=b6bc3975-51b5-420c-90a3-5af203516de3"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height/20,),
          const Align(
            alignment: Alignment.center,
            child:  Text(
              "Stay Ahead \n in tracking your donations",
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
