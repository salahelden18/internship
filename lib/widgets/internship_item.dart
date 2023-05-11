import 'package:flutter/material.dart';
import 'package:internship/widgets/space_height.dart';

import '../core/global/colors.dart';

class InternshipItem extends StatelessWidget {
  const InternshipItem({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1.5,
              color: thirdColor,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                offset: const Offset(
                  3.0,
                  3.0,
                ),
                blurRadius: 7.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              const SpaceHeight(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/intern.png',
                    width: 40,
                    height: 40,
                  ),
                  Image.asset(
                    'assets/images/waiting.png',
                    height: 30,
                    width: 30,
                  )
                ],
              )
            ],
          ),
        ),
        const SpaceHeight(),
      ],
    );
  }
}
