import 'package:flutter/material.dart';

import 'loading.dart';


class RoundButton extends StatelessWidget {
  final String title ;
  final Color color ;
  final VoidCallback onTap ;
  final bool loading ;
  final double size ;
  const RoundButton({Key? key ,
    required this.title,
    required this.onTap,
    this.loading = false,
    this.color=Colors.white,
    this.size = 15.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(child: loading ? Loading(size: size, color: color,) :
        Text(title, style: TextStyle(color: Colors.white),),),
      ),
    );
  }
}