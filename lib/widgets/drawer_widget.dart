import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/screens/auth/cubit/auth_cubit.dart';
import 'package:internship/screens/files_screen.dart';
import 'package:internship/screens/staticScreens/about_screen.dart';
import 'package:internship/screens/settings/settings_screen.dart';
import 'package:internship/widgets/divider_widget.dart';
import 'package:internship/widgets/home/drawer_item.dart';
import 'package:internship/widgets/home/drawer_user_item.dart';
import 'package:internship/widgets/space_height.dart';

import 'logo_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const DrawerUserItem(),
                      const DividerWidget(),
                      const SpaceHeight(height: 30),
                      DrawerItem(
                          onPress: () {
                            Navigator.of(context)
                                .pushNamed(FilesScreen.routeName);
                          },
                          text: 'Files'),
                      const SpaceHeight(),
                      DrawerItem(onPress: () {}, text: 'My Messages'),
                      const SpaceHeight(),
                      DrawerItem(
                          onPress: () {
                            Navigator.of(context)
                                .pushNamed(SettingSScreen.routeName);
                          },
                          text: 'Settings'),
                      const SpaceHeight(),
                      DrawerItem(
                          onPress: () {
                            Navigator.of(context)
                                .pushNamed(AboutScreen.routeName);
                          },
                          text: 'About'),
                      LogoWidget(size: size),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DividerWidget(),
                  TextButton.icon(
                    onPressed: () {
                      context.read<AuthCubit>().logout();
                    },
                    icon: const Icon(
                      Icons.exit_to_app_outlined,
                      color: Colors.black,
                    ),
                    label: Text(
                      'Logout',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
