import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/constants/api_constants.dart';
import 'package:internship/core/utils/open_file.dart';
import 'package:internship/core/widgets/show_toast.dart';
import 'package:internship/screens/announcement/announcement_screen.dart';
import 'package:internship/screens/home/cubit/home_cubit.dart';
import 'package:internship/screens/home/home_screen.dart';
import 'package:internship/screens/profile_screen.dart';
import 'package:internship/widgets/icon_button_widget.dart';

import '../core/utils/download_file.dart';
import '../widgets/files/file_item_wiget.dart';

class FilesScreen extends StatefulWidget {
  const FilesScreen({super.key});
  static const String routeName = '/files_screen';

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final data = BlocProvider.of<HomeCubit>(context).dataModel;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          if (_isLoading) const LinearProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1 / 1.2,
              ),
              itemCount: data?.downloadableFiles.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    File file = await downloadFile(
                        '${ApiConstants.baseUrl}/${data.downloadableFiles[index].file}');
                    openFile(file);
                  } catch (e) {
                    showToast(
                        'Unable to open the file please contact our support',
                        Colors.red);
                  }
                  setState(() {
                    _isLoading = false;
                  });
                },
                child:
                    FileItemWidget(text: data!.downloadableFiles[index].title),
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: _buildFloatingActionButton(context, data!, _controller),
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
            Navigator.of(context)
                .popUntil((route) => route.settings.name == '/');
          },
        ),
        IconButtonWidget(
          icon: Icons.person_2_outlined,
          onPress: () async {
            Navigator.of(context).pushNamed(ProfileScreen.routeName);
          },
        ),
      ],
    );
  }
}
