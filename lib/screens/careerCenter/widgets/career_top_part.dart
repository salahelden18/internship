import 'package:flutter/material.dart';

import '../../../core/global/colors.dart';
import '../model/career_center_model.dart';

class CareerTopPart extends StatelessWidget {
  const CareerTopPart(
    this.practiceSubmissionCareer, {
    super.key,
  });
  final PracticeSubmissionCareer practiceSubmissionCareer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        gradient: LinearGradient(
          colors: [
            primaryColor,
            secondaryColor,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            practiceSubmissionCareer.internshipTitle,
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            'Instructor: ${practiceSubmissionCareer.coordinatorName}',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
