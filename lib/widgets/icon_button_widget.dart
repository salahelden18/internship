import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    required this.icon,
    required this.onPress,
    this.color,
  });

  final IconData icon;
  final VoidCallback onPress;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: color,
      onPressed: onPress,
      icon: Icon(icon),
    );
  }
}
