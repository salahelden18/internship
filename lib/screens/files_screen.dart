import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/screens/announcement/announcement_screen.dart';
import 'package:internship/screens/home/cubit/home_cubit.dart';
import 'package:internship/screens/home/home_screen.dart';
import 'package:internship/widgets/icon_button_widget.dart';

import '../widgets/files/file_item_wiget.dart';

class FilesScreen extends StatelessWidget {
  const FilesScreen({super.key});
  static const String routeName = '/files_screen';

  @override
  Widget build(BuildContext context) {
    final files =
        BlocProvider.of<HomeCubit>(context).dataModel?.downloadableFiles;
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1 / 1.2,
            ),
            itemCount: files!.length,
            itemBuilder: (context, index) => InkWell(
                onTap: () async {},
                child: FileItemWidget(text: files[index].title)),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Files'),
      centerTitle: true,
      actions: [
        IconButtonWidget(
          icon: Icons.notifications_none_rounded,
          onPress: () {
            Navigator.of(context).pushNamed(AnnouncementScreen.routeName);
          },
        ),
        IconButtonWidget(
          icon: Icons.home_outlined,
          onPress: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                HomeScreen.routeName, (route) => false);
          },
        ),
        IconButtonWidget(
          icon: Icons.notifications,
          onPress: () {
            // Navigator.of(context).pushNamed(AnnouncementScreen.routeName);
          },
        ),
      ],
    );
  }
}
