import 'package:flutter/material.dart';
import 'package:internship/core/global/colors.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1.5,
      color: thirdColor,
    );
  }
}
