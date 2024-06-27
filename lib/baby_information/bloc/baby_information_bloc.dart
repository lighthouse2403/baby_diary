import 'package:bloc/src/bloc.dart';
import 'package:baby_diary/baby_information/baby_information_model.dart';
import 'package:baby_diary/baby_information/bloc/baby_information_event.dart';
import 'package:baby_diary/baby_information/bloc/baby_information_state.dart';
import 'package:baby_diary/common/base/bloc/base_bloc.dart';
import 'package:baby_diary/common/base/bloc/base_state.dart';
import 'package:baby_diary/common/extension/date_time_extension.dart';
import 'package:baby_diary/database/data_handler.dart';

class BabyInformationBloc extends BaseBloc {
  List<BabyInformationModel> babyList =[];
  BabyInformationModel? baby;

  BabyInformationBloc() : super() {
    on<SaveGenderEvent>(_saveGender);
    on<SaveBabyNameEvent>(_saveBabyName);
    on<SaveBirthDateEvent>(_saveBirthDate);
    on<InitBabyEvent>(_initCurrentBaby);
    on<SaveLastPriodEvent>(_saveLastPeriod);
  }

  Future<void> _initCurrentBaby(InitBabyEvent event, Emitter<BaseState> emit) async {
    try {
      emit(StartInitBaby());
      babyList = await DatabaseHandler.getAllBaby();
      baby = babyList.firstOrNull;
      emit(LoadingBabySuccessfullyState());
    } catch (error) {
      emit(LoadingBabyFailState());
    }
  }

  void _saveGender(SaveGenderEvent event, Emitter<BaseState> emit) async {
    emit(StartToChangeBabyInformation());
    baby ??= BabyInformationModel.init();
    baby?.gender = event.gender;
    DatabaseHandler.insertBaby(baby!);
    emit(LoadingBabySuccessfullyState());
  }

  void _saveBabyName(SaveBabyNameEvent event, Emitter<BaseState> emit) async {
    emit(StartToChangeBabyInformation());
    baby ??= BabyInformationModel.init();
    baby?.babyName = event.name;
    DatabaseHandler.insertBaby(baby!);
    emit(LoadingBabySuccessfullyState());
  }

  void _saveBirthDate(SaveBirthDateEvent event, Emitter<BaseState> emit) async {
    emit(StartToChangeBabyInformation());
    baby ??= BabyInformationModel.init();
    baby?.birthDate = event.time ?? DateTime.now();
    DatabaseHandler.insertBaby(baby!);
    emit(LoadingBabySuccessfullyState());
  }

  void _saveLastPeriod(SaveLastPriodEvent event, Emitter<BaseState> emit) async {
    emit(StartToChangeBabyInformation());
    baby ??= BabyInformationModel.init();
    DateTime lastPeriod = event.time ?? DateTime.now();
    baby?.birthDate = lastPeriod.convertFromLastPeriodToBirthDate();
    DatabaseHandler.insertBaby(baby!);
    emit(LoadingBabySuccessfullyState());
  }
}
