import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 20,
            child: Image.asset(
              "assets/logo.png",
              height: 100,
              width: 100,
            ),
          ),  Positioned(
            top: 150,
            child: Image.asset(
              "assets/img1.png",
              height: 200,
              width: 200,
            ),
          ),
          Positioned(
            top: 370,
            left: 3,
            right: 3,
            child: Text(
              "We help you to raise funds for your projects and any more text can be added here to make it look good",
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
