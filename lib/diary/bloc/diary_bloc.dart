import 'package:bloc/bloc.dart';
import 'package:baby_diary/database/data_handler.dart';
import 'package:baby_diary/diary/bloc/diary_event.dart';
import 'package:baby_diary/diary/bloc/diary_state.dart';
import 'package:baby_diary/diary/model/diary.dart';


class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  List<Diary> diaries = [];

  DiaryBloc() : super(const DiaryState()) {
    on<LoadDiariesEvent>(_loadDiaries);
    on<DeleteDiary>(_deleteDiary);
  }

  Future<void> _loadDiaries(LoadDiariesEvent event, Emitter<DiaryState> emit) async {
    try {
      emit(const StartLoadingState());
      diaries = await DatabaseHandler.getDiaries();
      emit(const LoadingSuccessfulState());
    } catch (error) {
      emit(const LoadingFailState());
    }
  }

  Future<void> _deleteDiary(DeleteDiary event, Emitter<DiaryState> emit) async {
    emit(const StartDeleteDiary());
    await DatabaseHandler.deleteAllDiary(event.diaryId);
    diaries.removeWhere((element) => element.diaryId == event.diaryId);
    emit(const LoadingSuccessfulState());
  }
}
