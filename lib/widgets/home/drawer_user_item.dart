import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/constants/api_constants.dart';
import 'package:internship/core/utils/get_name_from_email.dart';
import 'package:internship/screens/home/cubit/home_cubit.dart';
import 'package:internship/screens/home/update_cv_screen.dart';
import 'package:internship/widgets/space_height.dart';

class DrawerUserItem extends StatelessWidget {
  const DrawerUserItem({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<HomeCubit>().dataModel;
    return Row(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                userData!.profilePic.isNotEmpty
                    ? '${ApiConstants.baseUrl}/media/${userData.profilePic}'
                    : 'https://images.unsplash.com/photo-1571171637578-41bc2dd41cd2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8c29mdHdhcmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
              ),
            ),
            if (userData.cv == null)
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(UpdateCvScreen.routeName);
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(userData.email.isEmpty
                  ? 'Unknown'
                  : getNameFromEmail(userData.email)),
              const SpaceHeight(height: 10),
              Text(
                userData.email.isEmpty ? 'Unknown' : userData.email,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
