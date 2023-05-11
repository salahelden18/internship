import 'package:flutter/material.dart';
import 'package:internship/widgets/space_height.dart';

import '../core/global/colors.dart';

class InstructorStatusWidget extends StatelessWidget {
  const InstructorStatusWidget({
    required this.title,
    required this.description,
    required this.instructorName,
    super.key,
  });

  final String title;
  final String description;
  final String instructorName;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: thirdColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                const Flexible(
                  flex: 1,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontSize: 18, letterSpacing: 2),
                      ),
                      const SizedBox(height: 10),
                      Text('Description ($description)'),
                    ],
                  ),
                ),
              ],
            ),
            const SpaceHeight(height: 10),
            Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Instructor Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      letterSpacing: 2,
                    ),
                  ),
                  const SpaceHeight(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 30),
                      Text(
                        instructorName,
                        style: const TextStyle(fontSize: 18, letterSpacing: 2),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Image.asset(
                    'assets/images/intern.png',
                    height: 40,
                    width: 40,
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
