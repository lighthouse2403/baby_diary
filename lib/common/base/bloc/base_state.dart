import 'package:equatable/equatable.dart';

class BaseState extends Equatable {
  final bool? isLoading;
  String? error;

  BaseState({
    this.isLoading,
    this.error
  });

  @override
  List<Object?> get props => [isLoading, error];
}