import 'package:equatable/equatable.dart';

abstract class AuthStates extends Equatable {
  const AuthStates();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthStates {}

class AuthLoginLoadingState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

// class AuthenticatedState extends AuthStates {}

class StudentAuthenticatedState extends AuthStates {}

class CoordinatorAuthenticatedState extends AuthStates {}

class CareerCenterAuthenticatedState extends AuthStates {}

class NotAuthenticatedState extends AuthStates {}

class AuthenticateErrorState extends AuthStates {
  final String message;

  const AuthenticateErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class RegisteredSuccessfullyState extends AuthStates {
  final String message;

  const RegisteredSuccessfullyState(this.message);

  @override
  List<Object> get props => [message];
}
