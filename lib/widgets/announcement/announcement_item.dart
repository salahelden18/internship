import 'package:flutter/material.dart';

class AnnouncementItem extends StatelessWidget {
  const AnnouncementItem(
      {super.key,
      required this.text,
      required this.content,
      required this.date});
  final String text;
  final String content;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xffD9D9D9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: SizedBox(
                width: 60,
                child: Image.asset(
                  'assets/images/annouce.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Flexible(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Text(date),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
