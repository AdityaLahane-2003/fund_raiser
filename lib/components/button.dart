import 'package:flutter/material.dart';

import 'loading.dart';


class Button extends StatelessWidget {
  final String title ;
  final Color color ;
  final VoidCallback onTap ;
  final bool loading ;
  const Button({super.key ,
    required this.title,
    required this.onTap,
    this.loading = false,
    this.color=Colors.orange,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onPressed: () {
        onTap();
      },
      child:
      loading ? const Loading(size: 17, color: Colors.white,) :
      Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}