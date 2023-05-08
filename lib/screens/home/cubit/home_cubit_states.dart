import 'package:equatable/equatable.dart';

abstract class HomeStates extends Equatable {
  const HomeStates();

  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {}

class HomeErrorState extends HomeStates {
  final String message;

  const HomeErrorState(this.message);

  @override
  List<Object> get props => [message];
}
