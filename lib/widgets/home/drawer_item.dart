import 'package:flutter/material.dart';

import '../divider_widget.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({super.key, required this.onPress, required this.text});

  final VoidCallback onPress;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 5),
          const DividerWidget(),
        ],
      ),
    );
  }
}
