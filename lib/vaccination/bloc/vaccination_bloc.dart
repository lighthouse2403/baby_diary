import 'package:bloc/bloc.dart';
import 'package:baby_diary/common/firebase/firebase_vaccination.dart';
import 'package:baby_diary/database/data_handler.dart';
import 'package:baby_diary/vaccination/bloc/vaccination_event.dart';
import 'package:baby_diary/vaccination/bloc/vaccination_state.dart';
import 'package:baby_diary/vaccination/vaccination_model.dart';

class VaccinationBloc extends Bloc<VaccinationEvent, VaccinationState> {
  List<VaccinationModel> vaccinations = [];
  String location = 'Hà Nội';
  List<VaccinationModel> currentVaccination = [];

  VaccinationBloc() : super(const VaccinationState()) {
    on<LoadVaccination>(_loadVaccinations);
    on<UpdateRatingEvent>(_updateRating);
    on<UpdateNumberOfViewEvent>(_updateNumberOfView);
    on<RefreshVaccination>(_refreshVaccination);
    on<SearchVaccinationByLocation>(_searchVaccinationByLocation);
    on<SearchVaccinationByString>(_searchVaccinationByString);
  }

  Future<void> _searchVaccinationByLocation(SearchVaccinationByLocation event, Emitter<VaccinationState> emit) async {
    try {
      emit(const LoadingVaccinationState());
      location = event.location;
      currentVaccination = vaccinations.where((element) => (element.address ?? '').contains(location)).toList();
      emit(const LoadingVaccinationSuccessfulState());
    } catch (error) {
      emit(const LoadingVaccinationFailState());
    }
  }

  Future<void> _searchVaccinationByString(SearchVaccinationByString event, Emitter<VaccinationState> emit) async {
    try {
      emit(const LoadingVaccinationState());
      currentVaccination = vaccinations.where((element) {
        bool isLocation = (element.address ?? '').toLowerCase().contains(location.toLowerCase());
        bool isSearchAddress = (element.address ?? '').toLowerCase().contains(event.text.toLowerCase());
        bool isSearchName = (element.name ?? '').toLowerCase().contains(event.text.toLowerCase());

        return (isLocation && isSearchAddress) || (isLocation && isSearchName);
      }).toList();
      emit(const LoadingVaccinationSuccessfulState());
    } catch (error) {
      emit(const LoadingVaccinationFailState());
    }
  }

  Future<void> _loadVaccinations(VaccinationEvent event, Emitter<VaccinationState> emit) async {
    try {
      emit(const LoadingVaccinationState());
      vaccinations = await DatabaseHandler.getVaccinationList();
      if (vaccinations.isEmpty) {
        vaccinations = await FirebaseVaccination.instance.loadVaccination();
        await DatabaseHandler.updateVaccinationList(vaccinations);
      } else {
        FirebaseVaccination.instance.limit = vaccinations.length + 1;
      }

      emit(const LoadingVaccinationSuccessfulState());
    } catch (error) {
      emit(const LoadingVaccinationFailState());
    }
  }

  Future<void> _refreshVaccination(RefreshVaccination event, Emitter<VaccinationState> emit) async {
    try {
      emit(const LoadingVaccinationState());
      vaccinations = await FirebaseVaccination.instance.loadVaccination();
      await DatabaseHandler.deleteAllVaccination();
      await DatabaseHandler.updateVaccinationList(vaccinations);
      emit(const LoadingVaccinationSuccessfulState());
    } catch (error) {
      emit(const LoadingVaccinationFailState());
    }
  }

  Future<void> _updateRating(UpdateRatingEvent event, Emitter<VaccinationState> emit) async {
    try {
      emit(const LoadingVaccinationState());
      await FirebaseVaccination.instance.updateRating(event.vaccination, event.rating);
      emit(const UpdateVaccinationRatingSuccessfulState());
    } catch (error) {
      emit(const UpdateVaccinationRatingFailState());
    }
  }

  Future<void> _updateNumberOfView(UpdateNumberOfViewEvent event, Emitter<VaccinationState> emit) async {
    try {
      emit(const LoadingVaccinationState());
      await FirebaseVaccination.instance.updateView(event.vaccination);
      emit(const UpdateVaccinationNumberOfViewSuccessfulState());
    } catch (error) {
      emit(const UpdateVaccinationNumberOfViewFailState());
    }
  }
}
