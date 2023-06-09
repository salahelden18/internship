import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/screens/announcement/announcement_screen.dart';
import 'package:internship/screens/auth/cubit/auth_cubit.dart';
import 'package:internship/screens/home/cubit/home_cubit.dart';
import 'package:internship/screens/home/cubit/home_cubit_states.dart';
import 'package:internship/screens/internship_screen.dart';
import 'package:internship/screens/job/job_screen.dart';
import 'package:internship/screens/profile_screen.dart';
import 'package:internship/widgets/drawer_widget.dart';
import 'package:internship/widgets/home/home_item_widget.dart';
import 'package:internship/widgets/icon_button_widget.dart';
import 'package:internship/widgets/loading.dart';
import 'package:internship/widgets/logo_widget.dart';
import 'package:internship/widgets/space_height.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final data = context.watch<HomeCubit>().dataModel;
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: const DrawerWidget(),
      body: BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Loading();
        } else if (state is HomeErrorState) {
          return Center(
            child: Column(
              children: [
                Text(
                  state.message,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.read<AuthCubit>().logout();
                      },
                      child: const Text('Logout'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        return data?.year == null || data?.department == null
            ? Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Please Wait Until The Admin Add Your Year And Your Department Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: const Text('Exit'),
                    ),
                  ],
                ),
              )
            : ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  LogoWidget(size: size),
                  const SpaceHeight(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(InternshipScreen.routeName);
                    },
                    child: const HomeItemWidget(
                      imgPath: 'intern.png',
                      text: 'My Internships',
                    ),
                  ),
                  const SpaceHeight(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(JobScreen.routeName);
                    },
                    child: const HomeItemWidget(
                      imgPath: 'job.png',
                      text: 'Job Oppourtunities',
                    ),
                  ),
                ],
              );
      }),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButtonWidget(
          icon: Icons.notifications_outlined,
          onPress: () {
            Navigator.of(context).pushNamed(AnnouncementScreen.routeName);
          },
        ),
        IconButtonWidget(
          icon: Icons.person_2_outlined,
          onPress: () {
            Navigator.of(context).pushNamed(ProfileScreen.routeName);
          },
        ),
      ],
    );
  }
}
