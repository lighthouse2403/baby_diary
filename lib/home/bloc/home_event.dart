import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadBabyEvent extends HomeEvent {
  const LoadBabyEvent();

  @override
  List<Object?> get props => [];
}

class InitBabyEvent extends HomeEvent {
  InitBabyEvent();

  @override
  List<Object?> get props => [];
}