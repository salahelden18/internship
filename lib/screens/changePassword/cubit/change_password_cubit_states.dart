import 'package:equatable/equatable.dart';

abstract class ChangePasswordStates extends Equatable {
  const ChangePasswordStates();

  @override
  List<Object?> get props => [];
}

class ChangePasswordInitialState extends ChangePasswordStates {}

class ChangePasswordLoadingState extends ChangePasswordStates {}

class ChnagePasswordSuccessState extends ChangePasswordStates {}

class ChangePasswordErrorState extends ChangePasswordStates {
  final String message;

  const ChangePasswordErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
