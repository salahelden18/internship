import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/models/insurance_model.dart';
import 'package:internship/screens/careerCenter/cubit/career_states.dart';
import 'package:internship/screens/careerCenter/model/career_center_model.dart';
import 'package:internship/screens/careerCenter/services/career_service.dart';

class CareerCubit extends Cubit<CareerStates> {
  final CareerService careerService;

  CareerCubit(this.careerService) : super(InitialCareerState());

  CareerCenterModel? careerCenterModel;

  Future<void> getAllRequests() async {
    emit(GetLoadingCareerState());

    try {
      careerCenterModel = await careerService.getAllRequests();
      emit(GetLoadedCareerState());
    } on HttpException catch (e) {
      print(e);
      emit(GetErrorCareerState(e.message));
    } catch (e) {
      print(e);
      emit(const GetErrorCareerState('Something Went Wrong'));
    }
  }

  Future<void> updateTheSgk(String sgk, int id) async {
    emit(SGKLoadingCareerState());
    try {
      InsuranceModel insuranceModel = await careerService.updateTheSgk(sgk, id);
      int? index = careerCenterModel?.practiceSubmissions
          .indexWhere((element) => element.id == id);
      careerCenterModel?.practiceSubmissions[index!].insurance.insuranceFile =
          insuranceModel.insuranceFile;
      emit(SGKLoadedCareerState());
    } catch (e) {
      print(e);
      emit(const SGKErrorCareerState('Unable to upload'));
    }
  }
}
