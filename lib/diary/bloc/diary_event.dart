import 'package:equatable/equatable.dart';
import 'package:baby_diary/diary/model/diary.dart';

abstract class DiaryEvent extends Equatable {
  const DiaryEvent();
}

class LoadDiariesEvent extends DiaryEvent {
  const LoadDiariesEvent();

  @override
  List<Object?> get props => [];
}

class CreateDiary extends DiaryEvent {
  const CreateDiary();

  @override
  List<Object?> get props => [];
}

class EditDiary extends DiaryEvent {
  const EditDiary();

  @override
  List<Object?> get props => [];
}

class DeleteDiary extends DiaryEvent {
  DeleteDiary(this.diaryId);
  String diaryId;

  @override
  List<Object?> get props => [diaryId];
}

class AddedPath extends DiaryEvent {
  AddedPath(this.path);
  String path;

  @override
  List<Object?> get props => [path];
}

class DeletedPath extends DiaryEvent {
  DeletedPath(this.path);
  String path;

  @override
  List<Object?> get props => [path];
}

class InitDiary extends DiaryEvent {
  InitDiary(this.diary);
  Diary? diary;

  @override
  List<Object?> get props => [diary];
}
