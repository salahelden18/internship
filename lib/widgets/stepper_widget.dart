import 'dart:io';

import 'package:flutter/material.dart';
import 'package:internship/core/constants/api_constants.dart';
import 'package:internship/core/utils/download_file.dart';
import 'package:internship/core/utils/open_file.dart';
import 'package:internship/models/practice_submission.dart';

class StepperWidget extends StatelessWidget {
  const StepperWidget(
    this.internStatus, {
    super.key,
  });

  final PracticeSubmissions internStatus;

  int getCurrentStep() {
    if (internStatus.status == 0) {
      return 0;
    } else if (internStatus.status == 1 &&
        internStatus.insurance.insuranceFile == null) {
      return 1;
    } else if (internStatus.status == 1) {
      return 2;
    } else {
      return 2; // means unapproved and show error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(
          25,
        ),
      ),
      child: Stepper(
        controlsBuilder: (context, details) => Container(),
        currentStep: getCurrentStep(),
        steps: [
          Step(
            isActive: getCurrentStep() == 0,
            title: const Text('Under Review'),
            content: Column(
              children: const [
                Text(
                  'Your Application is Under Review',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Step(
            isActive: getCurrentStep() == 1,
            title: const Text('Waiting for SGK'),
            content: Column(
              children: const [
                Text('Your Application Approved But Waiting for SGK File'),
              ],
            ),
          ),
          internStatus.status == 2
              ? Step(
                  isActive: getCurrentStep() == 2,
                  title: const Text(
                    'UnApproved',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  content: Column(
                    children: [
                      const Text(
                          'We Are Sorry To Say That Your Application is Not Approved'),
                      if (internStatus.note!.isNotEmpty)
                        Text(internStatus.note!),
                    ],
                  ),
                )
              : Step(
                  isActive: getCurrentStep() == 2,
                  title: const Text('Approved'),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('You Can Now Start Your Internship'),
                      TextButton(
                        onPressed: () async {
                          File file = await downloadFile(
                              '${ApiConstants.baseUrl}/${internStatus.insurance.insuranceFile}');
                          await openFile(file);
                        },
                        child: const Text('See SGK'),
                      ),
                      const Text(
                        'Good Lock',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
