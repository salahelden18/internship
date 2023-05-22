import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/global/colors.dart';
import 'package:internship/core/utils/open_file.dart';
import 'package:internship/core/utils/pick_file.dart';
import 'package:internship/core/widgets/show_toast.dart';
import 'package:internship/models/internship_model.dart';
import 'package:internship/screens/home/cubit/home_cubit.dart';
import 'package:internship/screens/home/cubit/home_cubit_states.dart';
import 'package:internship/widgets/background_linear_gradient.dart';
import 'package:internship/widgets/create_official_letter_widget.dart';
import 'package:internship/widgets/custom_elevated_button.dart';
import 'package:internship/widgets/header_widget.dart';
import 'package:internship/widgets/home/floating_vertical_button.dart';
import 'package:internship/widgets/loading.dart';
import 'package:internship/widgets/main_content_widget.dart';
import 'package:internship/widgets/space_height.dart';
import 'package:path/path.dart';

enum International { international, notInternational }

// ignore: must_be_immutable
class InternshipApplayScreen extends StatefulWidget {
  const InternshipApplayScreen({super.key});
  static const String routeName = '/internship-applay-screen';

  @override
  State<InternshipApplayScreen> createState() => _InternshipApplayScreenState();
}

class _InternshipApplayScreenState extends State<InternshipApplayScreen>
    with TickerProviderStateMixin {
  bool _value = false;

  File? internForm;
  File? transkriptForm;
  File? companyHistoryForm;

  final TextEditingController _controller = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fetchedData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final internshipModel = fetchedData['model'] as InternshipModel;
    final email = fetchedData['email'] as String;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton:
          getFloatingVerticalButtons(context, _controller, internshipModel.id),
      // floatingActionButton: buildFloatingActionButton(context, email,
      //     _controller, internshipModel.coordinator.email, internshipModel.id),
      body: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            const BackgroundLinearGradient(),
            MainContentWidget(
              size: size,
              child: Column(
                children: [
                  HeaderWidget(
                    icon: Icons.work_history_outlined,
                    text: internshipModel.title,
                  ),
                  const SpaceHeight(),
                  _buildCheckBox(context),
                  const SpaceHeight(),
                  Row(
                    children: [
                      Expanded(
                        child: MyCustomButton(
                          height: 40,
                          width: 250,
                          text: internForm != null
                              ? basename(internForm!.path)
                              : 'Upload Form',
                          onPress: () async {
                            try {
                              if (internForm == null) {
                                internForm = await pickFile();
                                setState(() {});
                                if (internForm == null) {
                                  showToast(
                                      'No File Picked', Colors.orangeAccent);
                                }
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => _buildDialog(
                                    context,
                                    internForm!,
                                    () async {
                                      Navigator.pop(context);
                                      File? updatedForm = await pickFile();
                                      if (updatedForm != null) {
                                        internForm = updatedForm;
                                        setState(() {});
                                      }
                                    },
                                  ),
                                );
                              }
                            } catch (e) {
                              showToast('Unable to pick File', Colors.red);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: MyCustomButton(
                          height: 40,
                          width: 250,
                          text: transkriptForm != null
                              ? basename(transkriptForm!.path)
                              : 'Transkript',
                          onPress: () async {
                            try {
                              if (transkriptForm == null) {
                                transkriptForm = await pickFile();
                                setState(() {});
                                if (transkriptForm == null) {
                                  showToast(
                                      'No File Picked', Colors.orangeAccent);
                                }
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => _buildDialog(
                                    context,
                                    transkriptForm!,
                                    () async {
                                      Navigator.pop(context);
                                      File? updatedForm = await pickFile();
                                      if (updatedForm != null) {
                                        transkriptForm = updatedForm;
                                        setState(() {});
                                      }
                                    },
                                  ),
                                );
                              }
                            } catch (e) {
                              showToast('Unable to pick File', Colors.red);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SpaceHeight(),
                  // if (_value)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    constraints: BoxConstraints(
                        minHeight: _value == true ? 40 : 0,
                        maxHeight: _value == true ? 40 : 0),
                    curve: Curves.easeIn,
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: MyCustomButton(
                          height: 40,
                          width: double.infinity,
                          text: companyHistoryForm != null
                              ? basename(companyHistoryForm!.path)
                              : 'Company History',
                          onPress: () async {
                            try {
                              if (companyHistoryForm == null) {
                                companyHistoryForm = await pickFile();
                                setState(() {});
                                if (companyHistoryForm == null) {
                                  showToast(
                                      'No File Picked', Colors.orangeAccent);
                                }
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => _buildDialog(
                                    context,
                                    companyHistoryForm!,
                                    () async {
                                      Navigator.pop(context);
                                      File? updatedForm = await pickFile();
                                      if (updatedForm != null) {
                                        companyHistoryForm = updatedForm;
                                        setState(() {});
                                      }
                                    },
                                  ),
                                );
                              }
                            } catch (e) {
                              showToast('Unable to pick File', Colors.red);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SpaceHeight(height: 30),
                  BlocConsumer<HomeCubit, HomeStates>(
                    listener: (context, state) {
                      if (state is ApplyForInternSuccessState) {
                        showToast('Applied Successfully', Colors.green);
                      } else if (state is ApplyForInternErrorState) {
                        showToast(state.message, Colors.red);
                      }
                    },
                    builder: (context, state) {
                      if (state is ApplyForInternLoadingState) {
                        return const Loading();
                      }
                      return MyCustomButton(
                        height: 40,
                        width: double.infinity,
                        text: 'Apply Now',
                        onPress: () async {
                          if (internForm == null ||
                              transkriptForm == null ||
                              (_value == true && companyHistoryForm == null)) {
                            showToast(
                                'Make Sure That you uploaded all the required files',
                                Colors.red);
                          } else {
                            Map<String, dynamic> data = {
                              'internFile': internForm?.path,
                              'transkriptFile': transkriptForm?.path,
                              'isInternational': _value,
                              'id': internshipModel.id,
                            };

                            if (_value == true) {
                              data.putIfAbsent('companyHistoryFile',
                                  () => companyHistoryForm!.path);
                            }

                            await context.read<HomeCubit>().applyForIntern(
                                  data,
                                );
                          }
                        },
                      );
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

  AlertDialog _buildDialog(
      BuildContext context, File file, VoidCallback onTap) {
    return AlertDialog(
      content: Text('File Name: ${basename(file.path)}'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            openFile(file);
          },
          child: const Text(
            'Open',
            style: TextStyle(
              color: Colors.orange,
            ),
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: const Text(
            'Update',
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }

  CheckboxListTile _buildCheckBox(BuildContext context) {
    return CheckboxListTile(
      side: const BorderSide(color: thirdColor, width: 2),
      title: Text(
        'Is International',
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontSize: MediaQuery.of(context).size.width <= 320 ? 18 : 24,
              fontWeight: FontWeight.normal,
            ),
      ),
      subtitle: const Text(
        'Internship abroad',
      ),
      activeColor: thirdColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: thirdColor,
          width: 1.5,
        ),
      ),
      value: _value,
      onChanged: (val) {
        setState(() {
          _value = val!;
        });
        if (_value == false) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      },
    );
  }
}
