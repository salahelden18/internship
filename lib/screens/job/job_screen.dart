import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/global/colors.dart';
import 'package:internship/models/job_model.dart';
import 'package:internship/screens/announcement/announcement_screen.dart';
import 'package:internship/screens/home/cubit/home_cubit.dart';
import 'package:internship/screens/home/home_screen.dart';
import 'package:internship/screens/job/job_details_screen.dart';
import 'package:internship/widgets/divider_widget.dart';
import 'package:internship/widgets/icon_button_widget.dart';
import 'package:internship/widgets/space_height.dart';

import '../../widgets/job_item_widget.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({super.key});
  static const String routeName = '/job-screen';

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  List<JobModel> _filteredJobs = [];
  String _searchValue = '';

  @override
  Widget build(BuildContext context) {
    final jobs = BlocProvider.of<HomeCubit>(context).dataModel!.jobs;

    if (_searchValue.isNotEmpty) {
      _filteredJobs = jobs.where((job) {
        final title = job.title.toLowerCase();
        final searchText = _searchValue.toLowerCase();
        return title.contains(searchText);
      }).toList();
    } else {
      _filteredJobs = jobs;
    }

    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) => InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(JobDetailsScreen.routeName,
                  arguments: _filteredJobs[index]);
            },
            child: JobItemWidget(job: _filteredJobs[index])),
        separatorBuilder: (context, index) => const DividerWidget(),
        itemCount: _filteredJobs.length,
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: TextField(
        autofocus: false,
        // controller: _searchController,
        onChanged: (val) {
          setState(() {
            _searchValue = val;
          });
        },
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 16,
          ),
          hintText: 'Search...',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: secondaryColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: secondaryColor)),
        ),
      ),
      actions: [
        IconButtonWidget(
          icon: Icons.home_outlined,
          onPress: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                HomeScreen.routeName, (route) => false);
          },
        ),
        IconButtonWidget(
          icon: Icons.notifications_outlined,
          onPress: () {
            Navigator.of(context).pushNamed(AnnouncementScreen.routeName);
          },
        ),
      ],
    );
  }
}




//  Row(
//           children: [
//             Flexible(
//               flex: 2,
//               child: Container(
//                 padding: const EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(width: 1.5, color: Colors.grey),
//                 ),
//                 child: Image.asset('assets/images/intern.png'),
//               ),
//             ),
//             const SizedBox(width: 10),
//             Flexible(
//               flex: 6,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     _filteredJobs[index].title,
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SpaceHeight(height: 5),
//                   Text(
//                     _filteredJobs[index].company.title,
//                     style: const TextStyle(fontSize: 18, color: Colors.black54),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SpaceHeight(height: 5),
//                   Text(
//                     _filteredJobs[index].company.location,
//                     style: const TextStyle(color: Colors.black45),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SpaceHeight(height: 5),
//                   Text(
//                     _filteredJobs[index].employementType,
//                     style: const TextStyle(color: Colors.black38),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         )