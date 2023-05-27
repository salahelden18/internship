import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/global/http_exception.dart';
import 'package:internship/models/chats_model.dart';
import 'package:internship/models/data_model.dart';
import 'package:internship/models/message_model.dart';
import 'package:internship/models/practice_submission.dart';
import 'package:internship/screens/home/cubit/home_cubit_states.dart';
import 'package:internship/services/data_service.dart';

class HomeCubit extends Cubit<HomeStates> {
  final DataService _dataService;

  HomeCubit(this._dataService) : super(HomeInitialState());

  DataModel? dataModel;

  Future<void> getData() async {
    emit(HomeLoadingState());

    try {
      dataModel = await _dataService.getData();
      emit(HomeSuccessState());
    } on HttpException catch (e) {
      emit(HomeErrorState(e.message));
    } catch (e) {
      print(e);
      emit(const HomeErrorState('Something Went Wrong'));
    }
  }

  Future<void> updateCv(String cv) async {
    emit(UpdatignCvState());

    try {
      dataModel?.cv = await _dataService.updateCv(cv);
      emit(UpdateSuccessState());
    } catch (e) {
      print(e);
      emit(const UpdatingErrorState('Something Went Wrong'));
    }
  }

  Future<void> applyForIntern(Map<String, dynamic> data) async {
    emit(ApplyForInternLoadingState());

    try {
      PracticeSubmissions practiceSubmissions =
          await _dataService.internshipSubmit(data);

      dataModel!.internships
          .firstWhere((element) => element.id == practiceSubmissions.practise)
          .practiceSubmissions
          .add(practiceSubmissions);

      emit(ApplyForInternSuccessState());
    } on HttpException catch (e) {
      emit(ApplyForInternErrorState(e.message));
    } catch (e) {
      print(e);
      emit(const ApplyForInternErrorState('Something Went Wrong'));
    }
  }

  // Future<void> updateProfilePic(String profilePic) async {
  //   emit(UpdatignCvState());

  //   try {
  //     dataModel?.profilePic = await _dataService.updateUserProfilePic(profilePic);
  //     emit(UpdateSuccessState());
  //   } catch (e) {
  //     print(e);
  //     emit(const UpdatingErrorState('Something Went Wrong'));
  //   }
  // }

  Future<void> addMessage(int receiverId, String message) async {
    emit(AddLoadingMessage());
    try {
      ChatsModel chatsModel =
          await _dataService.addMessage(receiverId, message);

      int? index = dataModel?.chats.indexWhere(
        (element) => element.id == chatsModel.id,
      );

      if (index == null || index == -1) {
        dataModel?.chats.add(chatsModel);
      } else {
        dataModel?.chats[index].messages
            .add(chatsModel.messages[chatsModel.messages.length - 1]);
      }
      emit(AddLoadedMessage());
    } on HttpException catch (e) {
      print(e);
      emit(AddErrorMessage(e.message));
    } catch (e) {
      print(e);
      emit(const AddErrorMessage('Something Went Wrong'));
    }
  }
}
