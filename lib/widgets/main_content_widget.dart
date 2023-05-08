import 'package:flutter/material.dart';

class MainContentWidget extends StatelessWidget {
  const MainContentWidget({
    super.key,
    required this.size,
    required this.child,
  });

  final Size size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: size.height * 0.30,
      left: 10,
      right: 10,
      bottom: 0,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
