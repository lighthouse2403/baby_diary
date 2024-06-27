import 'package:bloc/bloc.dart';
import 'package:baby_diary/baby_weight/baby_weight_model.dart';
import 'package:baby_diary/baby_weight/bloc/baby_weight_event.dart';
import 'package:baby_diary/baby_weight/bloc/baby_weight_state.dart';
import 'package:baby_diary/database/data_handler.dart';

class BabyWeightBloc extends Bloc<BabyWeightEvent, BabyWeightState> {
  List<BabyWeight> babyWeightList = [];
  BabyWeight currentBabyWeight = BabyWeight.init();

  BabyWeightBloc() : super(const BabyWeightState()) {
    on<InitBabyWeightEvent>(_initCurrentBabyWeight);
    on<LoadBabyWeightEvent>(_loadBabyWeight);
    on<EditTimeEvent>(_editTime);
    on<EditWeightEvent>(_editWeight);
    on<SaveBabyWeightEvent>(_saveBabyWeight);
    on<DeleteBabyWeightEvent>(_deleteBabyWeight);

  }

  Future<void> _initCurrentBabyWeight(InitBabyWeightEvent event, Emitter<BabyWeightState> emit) async {
    try {
      emit(const StartLoadingBabyWeightState());
      if (event.babyWeight != null) {
        currentBabyWeight = event.babyWeight!;
      }
      emit(const LoadingBabyWeightSuccessful());
    } catch (error) {
      emit(const LoadingBabyWeightFailState());
    }
  }

  Future<void> _saveBabyWeight(SaveBabyWeightEvent event, Emitter<BabyWeightState> emit) async {
    try {
      emit(const StartSavingBabyWeightState());
      if (currentBabyWeight.weight == 0) {
        emit(const SaveBabyWeightFailState());
      }
      await DatabaseHandler.insertBabyWeight(currentBabyWeight);
      emit(const SaveBabyWeightSuccessfulState());
    } catch (error) {
      emit(const SaveBabyWeightFailState());
    }
  }

  Future<void> _editTime(EditTimeEvent event, Emitter<BabyWeightState> emit) async {
    try {
      emit(const StartEditBabyWeightState());
      currentBabyWeight.time = event.newTime;
      emit(const LoadingBabyWeightSuccessful());
    } catch (error) {
      emit(const LoadingBabyClothersFail());
    }
  }

  Future<void> _editWeight(EditWeightEvent event, Emitter<BabyWeightState> emit) async {
    try {
      emit(const StartEditBabyWeightState());
      int newValue = currentBabyWeight.weight + event.weight;
      if (newValue > 0) {
        currentBabyWeight.weight = newValue;
      }
      emit(const LoadingBabyWeightSuccessful());
    } catch (error) {
      emit(const LoadingBabyClothersFail());
    }
  }

  Future<void> _loadBabyWeight(LoadBabyWeightEvent event, Emitter<BabyWeightState> emit) async {
    try {
      emit(const StartLoadingBabyWeightState());
      babyWeightList = await DatabaseHandler.getAllBabyWeight();
      emit(const LoadingBabyWeightSuccessful());
    } catch (error) {
      emit(const LoadingBabyWeightFailState());
    }
  }

  Future<void> _deleteBabyWeight(DeleteBabyWeightEvent event, Emitter<BabyWeightState> emit) async {
    emit(const StartDeleteBabyWeightState());
    await DatabaseHandler.deleteBabyWeight(event.babyWeightId);
    babyWeightList.removeWhere((element) => element.babyWeightId == event.babyWeightId);
    emit(const LoadingBabyWeightSuccessful());
  }
}
