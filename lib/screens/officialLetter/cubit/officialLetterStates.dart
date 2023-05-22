import 'package:equatable/equatable.dart';

abstract class LetterStates extends Equatable {
  const LetterStates();

  @override
  List<Object> get props => [];
}

class InitialLetterState extends LetterStates {}

class LoadingLetterState extends LetterStates {}

class LoadedLetterState extends LetterStates {}

class ErrorLetterState extends LetterStates {
  final String message;

  const ErrorLetterState(this.message);

  @override
  List<Object> get props => [message];
}

class GetLoadingLettersState extends LetterStates {}

class GetLoadedLetterState extends LetterStates {}

class GetErrorLetterState extends LetterStates {
  final String message;

  const GetErrorLetterState(this.message);

  @override
  List<Object> get props => [message];
}
