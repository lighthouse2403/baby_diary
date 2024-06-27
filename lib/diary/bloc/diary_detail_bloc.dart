import 'package:bloc/bloc.dart';
import 'package:baby_diary/database/data_handler.dart';
import 'package:baby_diary/diary/bloc/diary_event.dart';
import 'package:baby_diary/diary/bloc/diary_state.dart';
import 'package:baby_diary/diary/model/diary.dart';

class DiaryDetailBloc extends Bloc<DiaryEvent, DiaryState> {
  Diary curentDiary = Diary.init();

  DiaryDetailBloc() : super(const DiaryState()) {
    on<CreateDiary>(_createDiary);
    on<EditDiary>(_editDiary);
    on<AddedPath>(_addPath);
    on<DeletedPath>(_deletePath);
    on<InitDiary>(_initDiaryDetail);
  }

  Future<void> _createDiary(DiaryEvent event, Emitter<DiaryState> emit) async {
    emit(const StartLoadingState());

    if (curentDiary.title.isEmpty) {
      emit(const SaveDiaryFail());
    }

    try {
      await DatabaseHandler.insertDiary(curentDiary);
      emit(const SaveDiarySuccessful());
    } catch (error) {
      emit(const LoadingFailState());
    }
  }

  Future<void> _editDiary(DiaryEvent event, Emitter<DiaryState> emit) async {
    emit(const StartLoadingState());
    if (curentDiary.title.isEmpty) {
      emit(const SaveDiaryFail());
    }
    try {
      await DatabaseHandler.updateDiary(curentDiary);
      emit(const SaveDiarySuccessful());
    } catch (error) {
      emit(const LoadingFailState());
    }
  }

  Future<void> _initDiaryDetail(InitDiary event, Emitter<DiaryState> emit) async {
    try {
      if (event.diary == null) {
        return;
      }
      emit(const StartInitDiary());
      curentDiary = event.diary ?? Diary.init();
      emit(const InitDiarySuccessful());
    } catch (error) {
      emit(const LoadingFailState());
    }
  }

  Future<void> _addPath(AddedPath event, Emitter<DiaryState> emit) async {
    if (event.path.isEmpty) {
      return;
    }

    emit(const StartAddingPath());
    List<String> currentPaths = curentDiary.mediaUrl;
    currentPaths.add(event.path);
    curentDiary.mediaUrl = currentPaths;
    emit(const AddingPathSuccessful());
  }

  Future<void> _deletePath(DeletedPath event, Emitter<DiaryState> emit) async {
    if (event.path.isEmpty) {
      return;
    }
    emit(const StartDeletingPath());
    List<String> currentPaths = curentDiary.mediaUrl;
    currentPaths.remove(event.path);
    curentDiary.mediaUrl = currentPaths;
    emit(const DeletingPathSuccessful());
  }
}
