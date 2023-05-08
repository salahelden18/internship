import 'package:flutter/material.dart';
import 'package:internship/core/global/colors.dart';

class MyCustomButton extends StatelessWidget {
  const MyCustomButton({
    super.key,
    required this.height,
    required this.width,
    required this.text,
    required this.onPress,
    this.borderRadius,
  });

  final BorderRadiusGeometry? borderRadius;
  final double width;
  final double height;
  final String text;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0);
    return InkWell(
      onTap: onPress,
      child: Material(
        elevation: 10,
        borderRadius: borderRadius,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                primaryColor,
                secondaryColor,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: borderRadius,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
