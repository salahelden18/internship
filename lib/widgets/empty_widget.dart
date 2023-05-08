import 'package:flutter/material.dart';
import 'package:internship/widgets/space_height.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, required this.text, required this.imgName});
  final String text;
  final String imgName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.50,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 24,
                decoration: TextDecoration.underline,
                color: Colors.black54,
              ),
            ),
            const SpaceHeight(),
            Image.asset(
              'assets/images/$imgName',
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
