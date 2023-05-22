import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/global/http_exception.dart';
import 'package:internship/models/letter_model.dart';
import 'package:internship/screens/officialLetter/cubit/officialLetterStates.dart';
import 'package:internship/services/official_letter.dart';

class LetterCubit extends Cubit<LetterStates> {
  final OfficialLetterService officialLetterService;

  LetterCubit(this.officialLetterService) : super(InitialLetterState());

  Future<void> letterApply(int id, String companyName) async {
    emit(LoadingLetterState());

    try {
      await officialLetterService.applyForOfficialLetter(id, companyName);
      emit(LoadedLetterState());
    } on HttpException catch (e) {
      emit(ErrorLetterState(e.message));
    } catch (e) {
      print(e);
      emit(const ErrorLetterState('Something Went Wrong'));
    }
  }

  List<LetterModel> requets = [];

  Future getAllLetetrs() async {
    emit(GetLoadingLettersState());

    try {
      requets = await officialLetterService.getAllLetters();
      emit(GetLoadedLetterState());
    } on HttpException catch (e) {
      print(e);
      emit(GetErrorLetterState(e.message));
    } catch (e) {
      print(e);
      emit(const GetErrorLetterState('Something Went Wrong'));
    }
  }
}
