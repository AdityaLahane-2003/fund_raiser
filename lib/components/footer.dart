import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key ,
  });

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo.png',
          height: 50,
        ),
        const Text(
          'Made with ',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const Icon(
          Icons.favorite,
          color: Colors.red,
          size: 12,
        ),
      ],
    );
  }
}