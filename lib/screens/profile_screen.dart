import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/utils/get_name_from_email.dart';
import 'package:internship/screens/home/cubit/home_cubit.dart';
import 'package:internship/widgets/background_linear_gradient.dart';
import 'package:internship/widgets/space_height.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const String routeName = '/profile-screen';

  @override
  Widget build(BuildContext context) {
    final data = context.watch<HomeCubit>().dataModel;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              const BackgroundLinearGradient(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    SpaceHeight(
                      height: MediaQuery.of(context).size.height * 0.30,
                    ),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        data!.profilePic.isNotEmpty
                            ? data.profilePic
                            : 'https://images.unsplash.com/photo-1571171637578-41bc2dd41cd2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8c29mdHdhcmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SpaceHeight(),
          Text(
            getNameFromEmail(data.email),
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
          const SpaceHeight(height: 10),
          Text(
            data.departmentName,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontSize: 18),
          )
        ],
      ),
    );
  }
}
