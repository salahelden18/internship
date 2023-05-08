import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/global/http_exception.dart';
import 'package:internship/screens/changePassword/cubit/change_password_cubit_states.dart';
import 'package:internship/services/change_password_service.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  final ChangePasswordService _changePasswordService;
  ChangePasswordCubit(this._changePasswordService)
      : super(ChangePasswordInitialState());

  Future<void> changeUserPassword(String oldPassword, newPassword) async {
    emit(ChangePasswordLoadingState());

    try {
      await _changePasswordService.changePassword(oldPassword, newPassword);
      emit(ChnagePasswordSuccessState());
    } on HttpException catch (e) {
      emit(ChangePasswordErrorState(e.message));
    } catch (e) {
      print(e);
      emit(const ChangePasswordErrorState('Something Went Wrong'));
    }
  }
}
