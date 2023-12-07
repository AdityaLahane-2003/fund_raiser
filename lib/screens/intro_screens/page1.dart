import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange[200],
      // margin: EdgeInsets.only(left: 25, right: 25),
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
children: [
          Positioned(
            top: 50,
            child: Image.asset(
              "assets/logo.png",
              height: 125,
              width: 125,
            ),
          ),  Positioned(
            top: 250,
            child: Image.asset(
              "assets/img1.png",
              height: 200,
              width: 200,
            ),
          ),
          Positioned(
            top: 500,
            left: 3,
            right: 3,
            child: Text(
              "We help you to raise funds for your projects and any more text can be added here to make it look good",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
