import 'package:flutter/material.dart';
import 'package:internship/core/global/colors.dart';
import 'package:internship/widgets/space_height.dart';

class HomeItemWidget extends StatelessWidget {
  const HomeItemWidget({
    super.key,
    required this.imgPath,
    required this.text,
  });

  final String text;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 190,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [primaryColor, secondaryColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 24),
                  maxLines: 1,
                ),
                const SpaceHeight(height: 10),
                Row(
                  children: const [
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 4,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SpaceHeight(),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/$imgPath', height: 50, width: 50),
              const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              )
            ],
          ),
        ],
      ),
    );
  }
}
