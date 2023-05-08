import 'package:flutter/material.dart';
import 'package:internship/screens/changePassword/change_password_screen.dart';
import 'package:internship/screens/staticScreens/privacy_policy_screen.dart';
import 'package:internship/widgets/background_linear_gradient.dart';
import 'package:internship/widgets/space_height.dart';

import '../../widgets/header_widget.dart';
import '../../widgets/list_tile_widget.dart';
import '../../widgets/main_content_widget.dart';

class SettingSScreen extends StatelessWidget {
  const SettingSScreen({super.key});

  static const String routeName = '/setting-screen';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            const BackgroundLinearGradient(),
            MainContentWidget(
              size: size,
              child: Column(
                children: [
                  const HeaderWidget(
                    icon: Icons.settings,
                    text: 'Account Settings',
                  ),
                  const SpaceHeight(),
                  ListTileWidget(
                    onPress: () {},
                    text: 'Edit Profile',
                  ),
                  const SpaceHeight(height: 10),
                  ListTileWidget(
                    onPress: () {
                      Navigator.of(context)
                          .pushNamed(ChangePasswordScreen.routeName);
                    },
                    text: 'Change Password',
                  ),
                  const SpaceHeight(height: 10),
                  ListTileWidget(
                    onPress: () {
                      Navigator.of(context)
                          .pushNamed(PrivacyPolicyScreen.routeName);
                    },
                    text: 'Privacy Policy',
                  ),
                  const SpaceHeight(height: 10),
                  ListTileWidget(
                    onPress: () {},
                    text: 'Logout',
                    icon: Icons.exit_to_app,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
