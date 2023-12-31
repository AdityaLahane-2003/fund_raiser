import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final double size;
  final Color color;
  const Loading({super.key, required this.size, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitChasingDots(
          color: color,
          size: size,
        ));
  }
}
