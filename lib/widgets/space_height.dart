import 'package:flutter/material.dart';

class SpaceHeight extends StatelessWidget {
  const SpaceHeight({super.key, this.height = 20});
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
