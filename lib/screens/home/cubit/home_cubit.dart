import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/global/http_exception.dart';
import 'package:internship/models/data_model.dart';
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
}
