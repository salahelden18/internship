import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/constants/api_constants.dart';
import 'package:internship/core/utils/get_name_from_email.dart';
import 'package:internship/screens/careerCenter/cubit/career_cubit.dart';
import 'package:internship/screens/careerCenter/cubit/career_states.dart';
import 'package:internship/screens/careerCenter/model/career_center_model.dart';
import 'package:internship/screens/careerCenter/sgk_screen.dart';
import 'package:internship/screens/careerCenter/widgets/career_top_part.dart';
import 'package:internship/widgets/loading.dart';
import 'package:internship/widgets/space_height.dart';

class ApprovedScreen extends StatelessWidget {
  const ApprovedScreen({super.key});
  static const String routeName = '/approved-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Approved',
          style:
              Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 24),
        ),
      ),
      body: BlocBuilder<CareerCubit, CareerStates>(
        builder: (context, state) {
          if (state is GetLoadingCareerState) {
            return const Loading();
          } else if (state is GetErrorCareerState) {
            return Center(
              child: Text(state.message),
            );
          }
          List<PracticeSubmissionCareer> practiceSubmissions = context
              .watch<CareerCubit>()
              .careerCenterModel!
              .practiceSubmissions
              .where((element) =>
                  element.insurance.insuranceFile == null &&
                  element.status == 1)
              .toList();

          print(practiceSubmissions.length);

          return practiceSubmissions.isEmpty
              ? const Center(
                  child: Text(
                    'There is no requests yet',
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: practiceSubmissions.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(SgkScreen.routeName,
                            arguments: practiceSubmissions[index]);
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 7,
                                    spreadRadius: 5,
                                    offset: const Offset(0, 3),
                                  )
                                ]),
                            child:
                                _buildMainContent(practiceSubmissions[index]),
                          ),
                          const SpaceHeight(),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

  Column _buildMainContent(PracticeSubmissionCareer practiceSubmissionCareer) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: CareerTopPart(practiceSubmissionCareer),
        ),
        Flexible(
          flex: 2,
          child: CareerBottomPart(practiceSubmissionCareer),
        ),
      ],
    );
  }
}

class CareerBottomPart extends StatelessWidget {
  const CareerBottomPart(
    this.practiceSubmissionCareer, {
    super.key,
  });
  final PracticeSubmissionCareer practiceSubmissionCareer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: ClipRRect(
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(20)),
            child: Image.network(
              '${ApiConstants.baseUrl}/media/${practiceSubmissionCareer.studentProfileImage}',
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getNameFromEmail(practiceSubmissionCareer.studentEmail),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                practiceSubmissionCareer.studentEmail,
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
