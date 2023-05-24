import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/global/colors.dart';
import 'package:internship/screens/auth/cubit/auth_cubit.dart';
import 'package:internship/screens/careerCenter/approved_screens.dart';
import 'package:internship/widgets/icon_button_widget.dart';
import 'package:internship/widgets/logo_widget.dart';
import 'package:internship/widgets/space_height.dart';

class CareerHomeScreen extends StatelessWidget {
  const CareerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Career Center',
          style: TextStyle(
            fontSize: 18,
            color: thirdColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButtonWidget(
            icon: Icons.exit_to_app,
            onPress: () {
              context.read<AuthCubit>().logout();
              // Navigator.of(context).pushNamed(ProfileScreen.routeName);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          LogoWidget(
            size: size,
          ),
          const SpaceHeight(),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ApprovedScreen.routeName);
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [primaryColor, secondaryColor],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: [
                  Text(
                    'Approved Internships',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/intern.png',
                        height: 40,
                        width: 40,
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SpaceHeight(),
          SizedBox(
            height: 100,
            width: size.width,
            child: Row(
              children: const [
                BuildCareerItem(
                  text: 'Posts',
                  icon: Icons.post_add_sharp,
                ),
                SizedBox(
                  width: 20,
                ),
                BuildCareerItem(
                  text: 'Announcement',
                  icon: Icons.announcement_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BuildCareerItem extends StatelessWidget {
  const BuildCareerItem({super.key, required this.icon, required this.text});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 24),
              ),
            ),
            Icon(
              icon,
              color: Colors.white,
              size: 35,
            ),
          ],
        ),
      ),
    );
  }
}
