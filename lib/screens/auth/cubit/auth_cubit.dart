import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/models/login_model.dart';
import 'package:internship/screens/auth/cubit/auth_states.dart';
import 'package:internship/services/authenticate_service.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthenticateService _authenticateService;
  AuthCubit(this._authenticateService) : super(AuthInitialState());

  Future<void> login(String email, String password) async {
    emit(AuthLoginLoadingState());

    try {
      LoginModel loginModel = await _authenticateService.login(email, password);

      if (loginModel.type == 'Career Center') {
        emit(CareerCenterAuthenticatedState());
      } else {
        emit(StudentAuthenticatedState());
      }

      // emit(AuthenticatedState());
    } on HttpException catch (e) {
      emit(AuthenticateErrorState(e.message));
    } catch (e) {
      print(e);
      emit(const AuthenticateErrorState('Something Went Wrong'));
    }
  }

  Future<void> signup(String email) async {
    emit(AuthLoginLoadingState());

    try {
      String message = await _authenticateService.signup(email);

      emit(RegisteredSuccessfullyState(message));
    } on HttpException catch (e) {
      emit(AuthenticateErrorState(e.message));
    } catch (e) {
      print(e);
      emit(const AuthenticateErrorState('Something Went Wrong'));
    }
  }

  Future<void> autoLogin() async {
    emit(AuthLoadingState());

    try {
      final LoginModel? loginModel = await _authenticateService.autoLogin();

      if (loginModel == null) {
        emit(NotAuthenticatedState());
      } else {
        if (loginModel.type == 'Career Center') {
          emit(CareerCenterAuthenticatedState());
        } else {
          emit(StudentAuthenticatedState());
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    emit(AuthLoadingState());

    try {
      _authenticateService.logout();
      emit(NotAuthenticatedState());
    } catch (e) {
      print(e);
      emit(const AuthenticateErrorState('Something Went Wrong'));
    }
  }
}
