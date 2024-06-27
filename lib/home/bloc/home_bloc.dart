import 'package:bloc/bloc.dart';
import 'package:baby_diary/baby_information/baby_information_model.dart';
import 'package:baby_diary/database/data_handler.dart';
import 'package:baby_diary/home/bloc/home_event.dart';
import 'package:baby_diary/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<BabyInformationModel> babyList = [];
  BabyInformationModel? currentBaby;

  HomeBloc() : super(const HomeState()) {
    on<InitBabyEvent>(_initCurrentBaby);
  }

  Future<void> _initCurrentBaby(InitBabyEvent event, Emitter<HomeState> emit) async {
    try {
      emit(const StartInitBaby());
      babyList = await DatabaseHandler.getAllBaby();
      currentBaby = babyList.firstOrNull;
      emit(const LoadingBabySuccessfullyState());
    } catch (error) {
      emit(const LoadingBabyFailState());
    }
  }
}
