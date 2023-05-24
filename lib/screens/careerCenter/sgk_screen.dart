import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/widgets/show_toast.dart';
import 'package:internship/screens/careerCenter/cubit/career_cubit.dart';
import 'package:internship/screens/careerCenter/cubit/career_states.dart';
import 'package:internship/screens/careerCenter/model/career_center_model.dart';
import 'package:internship/widgets/custom_elevated_button.dart';
import 'package:internship/widgets/loading.dart';
import 'package:internship/widgets/main_content_widget.dart';

import '../../core/global/colors.dart';
import '../../core/utils/open_file.dart';
import '../../widgets/background_linear_gradient.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/space_height.dart';

class SgkScreen extends StatefulWidget {
  const SgkScreen({super.key});
  static const String routeName = '/sgk-screen';

  @override
  State<SgkScreen> createState() => _SgkScreenState();
}

class _SgkScreenState extends State<SgkScreen> {
  File? sgkFile;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final practice =
        ModalRoute.of(context)!.settings.arguments as PracticeSubmissionCareer;
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
                    text: 'Upload SGK',
                  ),
                  const SpaceHeight(),
                  TextButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();

                      if (result != null) {
                        File file = File(result.files.single.path!);
                        setState(() {
                          sgkFile = file;
                        });
                      } else {
                        showToast('No File Picked', Colors.orange);
                      }
                    },
                    style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                      side: BorderSide(color: thirdColor, width: 1.5),
                    )),
                    child: const Text('Upload SGK'),
                  ),
                  const SpaceHeight(height: 10),
                  if (sgkFile != null)
                    GestureDetector(
                      onTap: () {
                        openFile(sgkFile!);
                      },
                      child: const Text(
                        'Show SGK',
                      ),
                    ),
                  const SpaceHeight(height: 10),
                  BlocConsumer<CareerCubit, CareerStates>(
                      listener: (context, state) {
                    if (state is SGKLoadedCareerState) {
                      showToast('Uploaded Successfully', Colors.green);
                      Navigator.pop(context);
                    } else if (state is SGKErrorCareerState) {
                      showToast(state.message, Colors.red);
                    }
                  }, builder: (context, state) {
                    if (state is SGKLoadingCareerState) {
                      return const Loading();
                    }
                    return MyCustomButton(
                      height: 40,
                      width: 250,
                      text: 'Send',
                      onPress: () {
                        print(practice.id);
                        context
                            .read<CareerCubit>()
                            .updateTheSgk(sgkFile!.path, practice.id);
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
