import 'package:flutter/material.dart';
import 'package:internship/core/utils/status_to_string.dart';
import 'package:internship/screens/home/home_screen.dart';
import 'package:internship/screens/internship_applay_screen.dart';
import 'package:internship/widgets/custom_elevated_button.dart';
import 'package:internship/widgets/icon_button_widget.dart';
import 'package:internship/widgets/space_height.dart';

import '../models/internship_model.dart';
import '../widgets/instructor_status_widget.dart';
import '../widgets/stepper_widget.dart';

class InternshipStatusScreen extends StatelessWidget {
  const InternshipStatusScreen({super.key});
  static const routeName = '/internship-status-screen';

  @override
  Widget build(BuildContext context) {
    // final data =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final internshipModel =
        ModalRoute.of(context)!.settings.arguments as InternshipModel;
    var internStatus = internshipModel.practiceSubmissions.firstWhere(
        (submission) => submission.status == 0 || submission.status == 1,
        orElse: () => internshipModel.practiceSubmissions[
            internshipModel.practiceSubmissions.length - 1]);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Status',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        actions: [
          IconButtonWidget(
              icon: Icons.home_outlined,
              onPress: () {
                Navigator.of(context)
                    .popUntil((route) => route.settings.name == '/');
              })
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          InstructorStatusWidget(
            title: internshipModel.title,
            description: statusToString(internStatus),
            instructorName: internshipModel.coordinator.name,
          ),
          const SpaceHeight(height: 10),
          StepperWidget(internStatus),
          const SpaceHeight(),
          if (internStatus.status == 2)
            MyCustomButton(
              height: 40,
              width: 200,
              text: 'Sumbit Again',
              onPress: () {
                Navigator.of(context).pushNamed(
                  InternshipApplayScreen.routeName,
                  arguments: internshipModel,
                );
              },
            ),
        ],
      ),
    );
  }
}
