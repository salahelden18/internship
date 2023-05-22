import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/global/colors.dart';
import 'package:internship/core/widgets/show_toast.dart';
import 'package:internship/screens/home/cubit/home_cubit.dart';
import 'package:internship/screens/home/cubit/home_cubit_states.dart';
import 'package:internship/widgets/custom_elevated_button.dart';
import 'package:internship/widgets/header_widget.dart';
import 'package:internship/widgets/loading.dart';
import 'package:internship/widgets/main_content_widget.dart';
import 'package:internship/widgets/space_height.dart';
import 'package:open_file_plus/open_file_plus.dart';

import '../../widgets/background_linear_gradient.dart';

class UpdateCvScreen extends StatefulWidget {
  const UpdateCvScreen({super.key});
  static const String routeName = '/update-cv-screen';

  @override
  State<UpdateCvScreen> createState() => _UpdateCvScreenState();
}

class _UpdateCvScreenState extends State<UpdateCvScreen> {
  bool isLoading = false;
  String? cvPath;

  void uploadCv() async {
    setState(() {
      isLoading = true;
    });

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    setState(() {
      isLoading = false;
    });

    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        cvPath = file.path;
      });
    } else {}
  }

  void openFile(String path) async {
    await OpenFile.open(path);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            const BackgroundLinearGradient(),
            MainContentWidget(
              size: size,
              child: Column(
                children: [
                  const HeaderWidget(
                    icon: Icons.work_history,
                    text: 'Upload Cv',
                  ),
                  const SpaceHeight(),
                  TextButton(
                    onPressed: uploadCv,
                    style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                      side: BorderSide(color: thirdColor, width: 1.5),
                    )),
                    child: const Text('Upload Your Cv'),
                  ),
                  const SpaceHeight(height: 10),
                  if (isLoading) const LinearProgressIndicator(),
                  if (cvPath != null)
                    GestureDetector(
                      onTap: () {
                        openFile(cvPath!);
                      },
                      child: const Text(
                        'Show Cv',
                      ),
                    ),
                  const SpaceHeight(),
                  BlocConsumer<HomeCubit, HomeStates>(
                    listener: (context, state) {
                      if (state is UpdatingErrorState) {
                        showToast(state.message, Colors.red);
                      } else if (state is UpdateSuccessState) {
                        showToast('Cv Updated', Colors.green);
                      }
                    },
                    builder: (context, state) {
                      if (state is UpdatignCvState) {
                        return const Loading();
                      } else {
                        return MyCustomButton(
                          height: 40,
                          width: 150,
                          text: 'Upload',
                          onPress: () {
                            if (cvPath != null) {
                              BlocProvider.of<HomeCubit>(context)
                                  .updateCv(cvPath!);
                            }
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
