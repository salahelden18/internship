import 'package:flutter/material.dart';

import '../../core/global/colors.dart';

class FileItemWidget extends StatelessWidget {
  const FileItemWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 3,
          color: const Color(0xffFCD770),
        ),
      ),
      child: Column(
        children: [
          Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 24),
          ),
          const Spacer(),
          Row(
            children: [
              Image.asset('assets/images/intern.png'),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
