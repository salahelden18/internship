import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/global/http_exception.dart';
import 'package:internship/screens/job/cubit/job_states.dart';
import 'package:internship/services/job_service.dart';

class JobCubit extends Cubit<JobStates> {
  JobService jobService;
  JobCubit(this.jobService) : super(JobApplyInitialState());

  Future<void> applyJob(String cv, int jobId) async {
    emit(JobApplyLoadingState());

    try {
      await jobService.applyForJob(cv, jobId);
      emit(JobApplySuccessState());
    } on HttpException catch (e) {
      emit(JobApplyErrorState(e.message));
    } catch (e) {
      print(e);
      emit(const JobApplyErrorState('Something Went Wrong'));
    }
  }
}
