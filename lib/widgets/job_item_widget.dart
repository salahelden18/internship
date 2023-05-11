import 'package:flutter/material.dart';
import 'package:internship/widgets/space_height.dart';

import '../models/job_model.dart';

class JobItemWidget extends StatelessWidget {
  const JobItemWidget({
    super.key,
    required this.job,
  });

  final JobModel job;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Container(
            height: 100,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1.5, color: Colors.grey),
            ),
            child: Image.network(
              job.company.logo,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          flex: 6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SpaceHeight(height: 5),
              Text(
                job.company.title,
                style: const TextStyle(fontSize: 18, color: Colors.black54),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SpaceHeight(height: 5),
              Text(
                job.company.location,
                style: const TextStyle(color: Colors.black45),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SpaceHeight(height: 5),
              Text(
                job.employementType,
                style: const TextStyle(color: Colors.black38),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
