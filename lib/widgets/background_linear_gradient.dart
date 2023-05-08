import 'package:flutter/material.dart';
import 'package:internship/core/global/colors.dart';
import 'package:internship/screens/home/home_screen.dart';
import 'package:internship/widgets/icon_button_widget.dart';

class BackgroundLinearGradient extends StatelessWidget {
  const BackgroundLinearGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        gradient: LinearGradient(
          colors: [
            primaryColor.withOpacity(0.6),
            secondaryColor.withOpacity(0.6),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButtonWidget(
                  icon: Icons.arrow_back,
                  onPress: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.white,
                ),
                IconButtonWidget(
                  icon: Icons.home_outlined,
                  onPress: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        HomeScreen.routeName, (route) => false);
                  },
                  color: Colors.white,
                ),
              ],
            ),
            Image.asset(
              'assets/images/logo.png',
              width: 180,
              height: 130,
            )
          ],
        ),
      ),
    );
  }
}
