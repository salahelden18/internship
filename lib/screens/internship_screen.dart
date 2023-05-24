import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/global/colors.dart';
import 'package:internship/screens/announcement/announcement_screen.dart';
import 'package:internship/screens/home/cubit/home_cubit.dart';
import 'package:internship/screens/internship_applay_screen.dart';
import 'package:internship/screens/internship_status_screen.dart';
import 'package:internship/screens/profile_screen.dart';
import 'package:internship/widgets/icon_button_widget.dart';

import '../widgets/internship_item.dart';

class InternshipScreen extends StatelessWidget {
  const InternshipScreen({super.key});
  static const String routeName = '/internship-screen';

  @override
  Widget build(BuildContext context) {
    final data = context.watch<HomeCubit>().dataModel;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          final bool done = data!.internships[index].practiceSubmissions
              .where((element) =>
                  element.insurance.insuranceFile != null &&
                  element.status == 1)
              .toList()
              .isNotEmpty;
          return GestureDetector(
            onTap: () {
              if (data.internships[index].practiceSubmissions.isEmpty) {
                Navigator.of(context).pushNamed(
                  InternshipApplayScreen.routeName,
                  arguments: data.internships[index],
                  // 'email': data.email,
                );
              } else {
                Navigator.of(context).pushNamed(
                  InternshipStatusScreen.routeName,
                  arguments: data.internships[index],
                  // 'email': data.email
                );
              }
            },
            child: InternshipItem(
                title: data.internships[index].title, approved: done),
          );
        },
        itemCount: data?.internships.length,
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Internships',
        style: TextStyle(color: thirdColor, fontSize: 24),
      ),
      actions: [
        IconButtonWidget(
          icon: Icons.notifications_none_outlined,
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
