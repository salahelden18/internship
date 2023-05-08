import 'package:flutter/material.dart';
import 'package:internship/models/job_model.dart';
import 'package:internship/widgets/custom_elevated_button.dart';
import 'package:internship/widgets/divider_widget.dart';
import 'package:internship/widgets/job_item_widget.dart';
import 'package:internship/widgets/space_height.dart';
import 'package:intl/intl.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});
  static const String routeName = '/job-detail-screen';

  @override
  Widget build(BuildContext context) {
    final job = ModalRoute.of(context)!.settings.arguments as JobModel;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(10),
          children: [
            JobItemWidget(job: job),
            const SpaceHeight(),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Requirements: ',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const DividerWidget(),
                    const SpaceHeight(),
                    Text(
                      job.description,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SpaceHeight(),
                    const DividerWidget(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          job.employementType,
                          style: const TextStyle(fontSize: 24),
                        ),
                        Text(
                          NumberFormat.currency().format(job.salary),
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SpaceHeight(),
            FractionallySizedBox(
              widthFactor: 0.5,
              child: MyCustomButton(
                height: 40,
                width: 250,
                text: 'Applay',
                onPress: () {},
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
