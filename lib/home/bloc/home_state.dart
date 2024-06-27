import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final bool? isSubmitting;

  const HomeState({this.isSubmitting,});

  @override
  List<Object?> get props => [isSubmitting];
}

class StartLoadingState extends HomeState {

  const StartLoadingState();

  @override
  List<Object?> get props => [];
}

class StartInitBaby extends HomeState {

  const StartInitBaby();

  @override
  List<Object?> get props => [];
}

class InitBabySuccessful extends HomeState {

  const InitBabySuccessful();

  @override
  List<Object?> get props => [];
}

class LoadingBabySuccessfullyState extends HomeState {

  const LoadingBabySuccessfullyState();

  @override
  List<Object?> get props => [];
}

class LoadingBabyFailState extends HomeState {

  const LoadingBabyFailState();

  @override
  List<Object?> get props => [];
}