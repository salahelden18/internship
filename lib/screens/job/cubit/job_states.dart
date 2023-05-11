import 'package:equatable/equatable.dart';

abstract class JobStates extends Equatable {
  const JobStates();

  @override
  List<Object> get props => [];
}

class JobApplyInitialState extends JobStates {}

class JobApplyLoadingState extends JobStates {}

class JobApplySuccessState extends JobStates {}

class JobApplyErrorState extends JobStates {
  final String message;

  const JobApplyErrorState(this.message);

  @override
  List<Object> get props => [message];
}
