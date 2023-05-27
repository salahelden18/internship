import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:internship/core/global/colors.dart';
import 'package:internship/core/utils/pick_file.dart';
import 'package:internship/screens/officialLetter/officailLettersScreen.dart';

import '../../core/widgets/show_toast.dart';
import '../../screens/officialLetter/cubit/officialLetterCubit.dart';
import '../../screens/officialLetter/cubit/officialLetterStates.dart';
import '../custom_elevated_button.dart';
import '../loading.dart';
import '../space_height.dart';

Widget getFloatingVerticalButtons(
    BuildContext context, TextEditingController controller, int id) {
  File? transcriptFileToBeSended;
  return SpeedDial(
    animatedIcon: AnimatedIcons.menu_close,
    animatedIconTheme: const IconThemeData(size: 22),
    backgroundColor: thirdColor,
    visible: true,
    curve: Curves.bounceIn,
    children: [
      // FAB 1
      SpeedDialChild(
          child: const Icon(
            Icons.add_task,
            color: Colors.white,
          ),
          backgroundColor: thirdColor,
          onTap: () async {
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
                      controller: controller,
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
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1.5,
                              color: thirdColor,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          File? trancriptFile = await pickFile();

                          if (trancriptFile == null) {
                            showToast('no file picked', Colors.orange);
                          } else {
                            transcriptFileToBeSended = trancriptFile;
                          }
                        },
                        child: const Text('Upload Trainscript'),
                      ),
                    ),
                    const SpaceHeight(),
                    Align(
                      alignment: Alignment.center,
                      child: FractionallySizedBox(
                        widthFactor: 0.5,
                        child: BlocConsumer<LetterCubit, LetterStates>(
                            listener: (context, state) {
                          if (state is LoadedLetterState) {
                            FocusScope.of(context).unfocus();
                            showToast('Applied Successfully', Colors.green);
                            controller.text = '';
                            Navigator.of(context).pop();
                          } else if (state is ErrorLetterState) {
                            FocusScope.of(context).unfocus();
                            showToast(state.message, Colors.red);
                          }
                        }, builder: (context, state) {
                          if (state is LoadingLetterState) {
                            return const Loading();
                          }
                          return MyCustomButton(
                            height: 40,
                            width: 250,
                            text: 'Ask For Official Letter',
                            onPress: () async {
                              if (controller.text.isEmpty) {
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
                                    content: const Text(
                                        'Please Enter The Company Name'),
                                  ),
                                );
                              } else {
                                if (transcriptFileToBeSended == null) {
                                  showToast('please Pick a file', Colors.red);
                                } else {
                                  if (context.mounted) {
                                    context.read<LetterCubit>().letterApply(
                                        id,
                                        controller.text,
                                        transcriptFileToBeSended!.path);
                                  }
                                }

                                // createOfficialLetter(
                                //     controller.text, email, coordinatorName);
                              }
                            },
                          );
                        }),
                      ),
                    ),
                    const SpaceHeight(),
                  ],
                ),
              ),
            );
          },
          label: 'Request Official Letter',
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 16.0,
          ),
          labelBackgroundColor: thirdColor),
      // FAB 2
      SpeedDialChild(
        child: const Icon(
          Icons.approval_outlined,
          color: Colors.white,
        ),
        backgroundColor: thirdColor,
        onTap: () {
          Navigator.of(context).pushNamed(OfficailLetterScreen.routeName);
        },
        label: 'All Requets',
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: 16.0,
        ),
        labelBackgroundColor: thirdColor,
      )
    ],
  );
}
