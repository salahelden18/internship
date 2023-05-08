import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/screens/announcement/announcement_screen.dart';
import 'package:internship/screens/home/cubit/home_cubit.dart';
import 'package:internship/screens/home/cubit/home_cubit_states.dart';
import 'package:internship/screens/job/job_screen.dart';
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
                      onPressed: () {},
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
        return ListView(
          padding: const EdgeInsets.all(15),
          children: [
            LogoWidget(size: size),
            const SpaceHeight(
              height: 30,
            ),
            const HomeItemWidget(
              imgPath: 'intern.png',
              text: 'My Internships',
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
          icon: Icons.notifications,
          onPress: () {
            Navigator.of(context).pushNamed(AnnouncementScreen.routeName);
          },
        ),
        IconButtonWidget(
          icon: Icons.person_2_outlined,
          onPress: () {},
        ),
      ],
    );
  }
}
