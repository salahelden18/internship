import 'package:flutter/material.dart';
import 'package:internship/screens/home/home_screen.dart';
import 'package:internship/widgets/icon_button_widget.dart';

import '../core/global/colors.dart';

class SmallbackgroundLinearGradient extends StatelessWidget {
  const SmallbackgroundLinearGradient({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height <= 534 ? size.height * 0.20 : size.height * 0.15,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        gradient: LinearGradient(
          colors: [
            primaryColor,
            secondaryColor,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButtonWidget(
                  icon: Icons.arrow_back,
                  color: Colors.white,
                  onPress: () {
                    Navigator.of(context).pop();
                  },
                ),
                IconButtonWidget(
                  icon: Icons.home_outlined,
                  color: Colors.white,
                  onPress: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        HomeScreen.routeName, (route) => false);
                  },
                ),
              ],
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                letterSpacing: 2,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
