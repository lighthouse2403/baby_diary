import 'package:equatable/equatable.dart';
import 'package:baby_diary/common/constants/constants.dart';

abstract class IndexEvent extends Equatable {
  const IndexEvent();
}

class LoadIndexEvent extends IndexEvent {
  const LoadIndexEvent();

  @override
  List<Object?> get props => [];
}
