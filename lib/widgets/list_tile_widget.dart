import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    super.key,
    required this.onPress,
    required this.text,
    this.icon = Icons.arrow_forward_ios_outlined,
  });

  final String text;
  final VoidCallback onPress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onPress,
      leading: Text(text),
      trailing: Icon(
        icon,
        size: 16,
      ),
    );
  }
}
