import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:baby_diary/vaccination/vaccination_model.dart';

class FirebaseVaccination {
  FirebaseVaccination._();

  static final instance = FirebaseVaccination._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int limit = 300;
  String collection = 'vaccination';

  Future<List<VaccinationModel>> loadVaccination() async {
    limit += 50;
    QuerySnapshot chatSnapshot = await firestore.collection(collection).limit(limit).get();
    final allData = chatSnapshot.docs.map((doc) {
      return VaccinationModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();

    return allData;
  }

  Future<void> updateRating(VaccinationModel vaccination, int rating) async {
    CollectionReference chat = firestore.collection(collection);
    List<int> newRating = vaccination.rate ?? [];
    newRating.add(rating);

    await chat.doc(vaccination.vaccinationId).update({
      'rate' : newRating
    });
  }

  Future<void> updateView(VaccinationModel vaccination) async {
    CollectionReference chat = firestore.collection(collection);
    int newViews = vaccination.view ?? 0;

    await chat.doc(vaccination.vaccinationId).update({
      'view' : newViews + 1
    });
  }
}