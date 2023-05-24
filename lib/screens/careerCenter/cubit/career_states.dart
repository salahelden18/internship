import 'package:equatable/equatable.dart';

abstract class CareerStates extends Equatable {
  const CareerStates();

  @override
  List<Object> get props => [];
}

class InitialCareerState extends CareerStates {}

class GetLoadingCareerState extends CareerStates {}

class GetLoadedCareerState extends CareerStates {}

class GetErrorCareerState extends CareerStates {
  final String message;

  const GetErrorCareerState(this.message);

  @override
  List<Object> get props => [message];
}

class SGKLoadingCareerState extends CareerStates {}

class SGKLoadedCareerState extends CareerStates {}

class SGKErrorCareerState extends CareerStates {
  final String message;

  const SGKErrorCareerState(this.message);

  @override
  List<Object> get props => [message];
}
