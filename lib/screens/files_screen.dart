import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/constants/api_constants.dart';
import 'package:internship/core/global/colors.dart';
import 'package:internship/core/utils/create_officail_letter.dart';
import 'package:internship/core/utils/open_file.dart';
import 'package:internship/core/widgets/show_toast.dart';
import 'package:internship/models/data_model.dart';
import 'package:internship/screens/announcement/announcement_screen.dart';
import 'package:internship/screens/home/cubit/home_cubit.dart';
import 'package:internship/screens/home/home_screen.dart';
import 'package:internship/screens/profile_screen.dart';
import 'package:internship/widgets/custom_elevated_button.dart';
import 'package:internship/widgets/icon_button_widget.dart';
import 'package:internship/widgets/space_height.dart';

import '../core/utils/download_file.dart';
import '../widgets/files/file_item_wiget.dart';

class FilesScreen extends StatefulWidget {
  const FilesScreen({super.key});
  static const String routeName = '/files_screen';

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  final TextEditingController _controller = TextEditingController();

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
      floatingActionButton: _buildFloatingActionButton(context, data!),
    );
  }

  FloatingActionButton _buildFloatingActionButton(
      BuildContext context, DataModel data) {
    return FloatingActionButton.extended(
      onPressed: () async {
        await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => Padding(
            padding: EdgeInsets.only(
                top: 20,
                right: 10,
                left: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Company Name',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(letterSpacing: 0),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _controller,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Enter Company Name',
                    prefixIcon: Icon(Icons.work),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: thirdColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: thirdColor)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: thirdColor)),
                  ),
                ),
                const SpaceHeight(),
                Align(
                  alignment: Alignment.center,
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    child: MyCustomButton(
                      height: 40,
                      width: 250,
                      text: 'Create Official Letter',
                      onPress: () {
                        if (_controller.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Ok',
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                              content:
                                  const Text('Please Enter The Company Name'),
                            ),
                          );
                        } else {
                          Navigator.pop(context);
                          createOfficialLetter(_controller.text, data.email);
                        }
                      },
                    ),
                  ),
                ),
                const SpaceHeight(),
              ],
            ),
          ),
        );
      },
      label: const Text(
        'Official Letter',
      ),
      icon: const Icon(Icons.add_task),
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
          icon: Icons.person_2_outlined,
          onPress: () async {
            Navigator.of(context).pushNamed(ProfileScreen.routeName);
          },
        ),
      ],
    );
  }
}
