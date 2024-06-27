import 'package:equatable/equatable.dart';
import 'package:baby_diary/vaccination/vaccination_model.dart';

abstract class VaccinationEvent extends Equatable {
  const VaccinationEvent();
}

class LoadVaccination extends VaccinationEvent {
  const LoadVaccination();

  @override
  List<Object?> get props => [];
}

class RefreshVaccination extends VaccinationEvent {
  const RefreshVaccination();

  @override
  List<Object?> get props => [];
}

class UpdateRatingEvent extends VaccinationEvent {
  VaccinationModel vaccination;
  int rating;
  UpdateRatingEvent(this.rating, this.vaccination);

  @override
  List<Object?> get props => [rating, vaccination];
}

class UpdateNumberOfViewEvent extends VaccinationEvent {
  VaccinationModel vaccination;
  UpdateNumberOfViewEvent(this.vaccination);

  @override
  List<Object?> get props => [vaccination];
}

class SearchVaccinationByLocation extends VaccinationEvent {
  String location;
  SearchVaccinationByLocation(this.location);

  @override
  List<Object?> get props => [location];
}

class SearchVaccinationByString extends VaccinationEvent {
  String text;
  SearchVaccinationByString(this.text);

  @override
  List<Object?> get props => [text];
}