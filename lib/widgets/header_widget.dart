import 'package:flutter/material.dart';
import 'package:internship/widgets/space_height.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.icon,
    required this.text,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontSize: 20),
            ),
            Icon(
              icon,
              color: Colors.black54,
            ),
          ],
        ),
        const SpaceHeight(
          height: 10,
        ),
        const Divider(
          color: Color(0xffCACACA),
          thickness: 1.5,
        )
      ],
    );
  }
}
