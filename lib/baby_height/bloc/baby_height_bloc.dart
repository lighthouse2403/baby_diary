import 'package:baby_diary/baby_height/bloc/baby_height_event.dart';
import 'package:baby_diary/baby_height/height_model.dart';
import 'package:bloc/src/bloc.dart';
import 'package:baby_diary/baby_information/bloc/baby_information_state.dart';
import 'package:baby_diary/common/base/bloc/base_bloc.dart';
import 'package:baby_diary/common/base/bloc/base_state.dart';

class BabyHeightBloc extends BaseBloc {
  List<HeightModel> heightList =[];
  HeightModel? currentBabyHeight;

  BabyHeightBloc() : super() {
    on<SaveBabyHeightEvent>(_saveBabyHeight);
    on<DeleteBabyHeightEvent>(_deleteBabyHeight);
    on<InitBabyHeightEvent>(_initBabyHeight);
  }

  Future<void> _initBabyHeight(InitBabyHeightEvent event, Emitter<BaseState> emit) async {
    try {
      emit(StartInitBaby());
      currentBabyHeight = event.height;
      emit(LoadingBabySuccessfullyState());
    } catch (error) {
      emit(LoadingBabyFailState());
    }
  }

  void _saveBabyHeight(SaveBabyHeightEvent event, Emitter<BaseState> emit) async {
    emit(StartToChangeBabyInformation());
    currentBabyHeight = event.height;
    emit(LoadingBabySuccessfullyState());
  }

  void _deleteBabyHeight(DeleteBabyHeightEvent event, Emitter<BaseState> emit) async {
    emit(StartToChangeBabyInformation());
    emit(LoadingBabySuccessfullyState());
  }
}
