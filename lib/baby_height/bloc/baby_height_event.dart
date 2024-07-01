import 'package:baby_diary/baby_height/height_model.dart';
import 'package:baby_diary/common/base/bloc/base_event.dart';

class BabyHeightEvent extends BaseEvent {

  const BabyHeightEvent();

  @override
  List<Object?> get props => [];
}

class InitBabyHeightEvent extends BaseEvent {
  HeightModel height;
  InitBabyHeightEvent(this.height);

  @override
  List<Object?> get props => [height];
}

class LoadBabyHeightEvent extends BaseEvent {
  const LoadBabyHeightEvent();

  @override
  List<Object?> get props => [];
}

class DeleteBabyHeightEvent extends BaseEvent {
  DeleteBabyHeightEvent(this.height);
  HeightModel height;
  @override
  List<Object?> get props => [height];
}

class SaveBabyHeightEvent extends BaseEvent {
  SaveBabyHeightEvent(this.height);
  HeightModel height;

  @override
  List<Object?> get props => [height];
}