import 'package:baby_diary/baby_information/baby_information_model.dart';
import 'package:flutter/foundation.dart';
import 'package:baby_diary/baby_weight/baby_weight_model.dart';
import 'package:baby_diary/diary/model/diary.dart';
import 'package:baby_diary/doctor/doctor_model.dart';
import 'package:baby_diary/vaccination/vaccination_model.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHandler {
  static String databasePath = 'pregnancy.db';
  static String babyTable = 'babies';
  static String doctorTable = 'doctors';
  static String diaryTable = 'diaries';
  static String vaccinationTable = 'vaccination';
  static String notificationsTable = 'notifications';
  static String babyKickTable = 'babyKick';
  static String motherWeightTable = 'motherWeight';
  static String scheduleTable = 'schedule';
  static String babyWeightTable = 'babyWeight';
  static String babyClothersTable = 'babyClothers';
  static String favoriteNameTable = 'favoriteName';

  static Future<sql.Database> db(String tableName) async {
    return sql.openDatabase(
      DatabaseHandler.databasePath,
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<void> createTables(sql.Database database) async {
    await database.execute("CREATE TABLE $babyTable(babyId TEXT PRIMARY KEY, babyName TEXT, gender INTEGER, birthDate INTEGER, createdTime INTEGER, updatedTime INTEGER)");
    await database.execute("CREATE TABLE $babyWeightTable(babyWeightId TEXT PRIMARY KEY, weight INTEGER, note TEXT, time INTEGER, createdTime INTEGER, updatedTime INTEGER, babyId TEXT)");
    await database.execute("CREATE TABLE $diaryTable(diaryId TEXT PRIMARY KEY, title TEXT, content TEXT, time INTEGER, createdTime INTEGER, updatedTime INTEGER, mediaUrl TEXT)");
    await database.execute("CREATE TABLE $doctorTable(doctorId TEXT PRIMARY KEY, name TEXT, address TEXT, time TEXT, hospital TEXT, phone INTEGER, description TEXT, rate TEXT, view INTEGER)");
    await database.execute("CREATE TABLE $vaccinationTable(vaccinationId TEXT PRIMARY KEY, name TEXT, address TEXT, time TEXT, phone INTEGER, rate TEXT, view INTEGER)");
    await database.execute("CREATE TABLE $babyKickTable(babyKickId TEXT PRIMARY KEY, babyId TEXT, time INTEGER, createdTime INTEGER, updatedTime INTEGER, duration INTEGER, startTime INTEGER, quantity INTEGER)");
    await database.execute("CREATE TABLE $motherWeightTable(weightId TEXT PRIMARY KEY, babyId TEXT, weight INTEGER, createdTime INTEGER, updatedTime INTEGER, time INTEGER)");
    await database.execute("CREATE TABLE $scheduleTable(scheduleId TEXT PRIMARY KEY, babyId TEXT, content TEXT, time INTEGER, createdTime INTEGER, updatedTime INTEGER, isAlarm INTEGER, location TEXT)");
    await database.execute("CREATE TABLE $notificationsTable(notificationId TEXT PRIMARY KEY, title TEXT, time INTEGER, createdTime INTEGER, updatedTime INTEGER, url TEXT, content TEXT)");
    await database.execute("CREATE TABLE $babyClothersTable(babyClothersId TEXT PRIMARY KEY, babyId TEXT, name TEXT, quantity INTEGER, time INTEGER, createdTime INTEGER, updatedTime INTEGER, note TEXT, unit TEXT, isFinished INTEGER, isAlarm INTEGER, type TEXT)");
    await database.execute("CREATE TABLE $favoriteNameTable(babyName TEXT PRIMARY KEY)");
  }

  static Future<void> clearData() async {
    sql.deleteDatabase(DatabaseHandler.databasePath);
  }

  /// Handle Baby weight
  static Future<void> insertBaby(BabyInformationModel baby) async {
    final db = await DatabaseHandler.db(babyTable);
    await db.insert(
      babyTable,
      baby.toJson(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<BabyInformationModel> getBaby(String id) async {
    final db = await DatabaseHandler.db(babyTable);
    final List<Map<String, dynamic>> maps = await db.query(babyTable, where: 'babyId = ?', whereArgs: [id]);
    return BabyInformationModel.fromDatabase(maps.first);
  }

  static Future<List<BabyInformationModel>> getAllBaby() async {
    final db = await DatabaseHandler.db(babyTable);
    final List<Map<String, dynamic>> list = await db.query(babyTable);
    return list.map((e) => BabyInformationModel.fromDatabase(e)).toList();
  }

  // Update an item by id
  static Future<void> updateBaby(BabyInformationModel baby) async {
    final db = await DatabaseHandler.db(babyTable);

    await db.update(
      babyTable,
      baby.toJson(),
      // Ensure that the Dog has a matching id.
      where: 'babyId = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [baby.babyId],
    );
  }

  // Delete
  static Future<void> deleteBaby(String babyId) async {
    final db = await DatabaseHandler.db(babyTable);
    try {
      await db.delete(
          babyTable,
          where: "babyId = ?",
          whereArgs: [babyId]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> deleteAllBaby() async {
    final db = await DatabaseHandler.db(babyTable);
    try {
      await db.delete(
          babyTable
      );
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  /// Handle Baby weight
  static Future<void> insertBabyWeight(BabyWeight weight) async {
    final db = await DatabaseHandler.db(babyWeightTable);
    await db.insert(
      babyWeightTable,
      weight.toJson(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<BabyWeight> getBabyWeight(String id) async {
    final db = await DatabaseHandler.db(babyWeightTable);
    final List<Map<String, dynamic>> maps = await db.query(babyWeightTable, where: 'babyWeightId = ?', whereArgs: [id]);
    return BabyWeight.fromDatabase(maps.first);
  }

  static Future<List<BabyWeight>> getAllBabyWeight() async {
    final db = await DatabaseHandler.db(babyWeightTable);
    final List<Map<String, dynamic>> list = await db.query(babyWeightTable);
    return list.map((e) => BabyWeight.fromDatabase(e)).toList();
  }

  // Update an item by id
  static Future<void> updateBabyWeight(BabyWeight weight) async {
    final db = await DatabaseHandler.db(babyWeightTable);

    await db.update(
      babyWeightTable,
      weight.toJson(),
      // Ensure that the Dog has a matching id.
      where: 'babyWeightId = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [weight.babyWeightId],
    );
  }

  // Delete
  static Future<void> deleteBabyWeight(String babyWeightId) async {
    final db = await DatabaseHandler.db(babyWeightTable);
    try {
      await db.delete(
          babyWeightTable,
          where: "babyWeightId = ?",
          whereArgs: [babyWeightId]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> deleteAllBabyWeight() async {
    final db = await DatabaseHandler.db(babyWeightTable);
    try {
      await db.delete(
          babyWeightTable
      );
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  /// Handle diaries table
  static Future<void> insertDiary(Diary diary) async {
    final db = await DatabaseHandler.db(diaryTable);
    await db.insert(
      diaryTable,
      diary.toJson(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  // Read all items (journals)
  static Future<Diary> getDiary(String diaryId) async {
    final db = await DatabaseHandler.db(diaryTable);
    final List<Map<String, dynamic>> maps = await db.query(diaryTable, where: 'diaryId = ?', whereArgs: [diaryId]);
    return Diary.fromDatabase(maps.first);
  }

  static Future<List<Diary>> getDiaries() async {
    final db = await DatabaseHandler.db(diaryTable);
    final List<Map<String, dynamic>> list = await db.query(diaryTable);
    return list.map((e) => Diary.fromDatabase(e)).toList();
  }

  // Update an item by id
  static Future<void> updateDiary(Diary diary) async {
    final db = await DatabaseHandler.db(diaryTable);

    await db.update(
      diaryTable,
      diary.toJson(),
      // Ensure that the Dog has a matching id.
      where: 'diaryId = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [diary.diaryId],
    );
  }

  // Delete
  static Future<void> deleteDiary(String diaryId) async {
    final db = await DatabaseHandler.db(diaryTable);
    try {
      await db.delete(
          diaryTable,
          where: "diaryId = ?",
          whereArgs: [diaryId]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> deleteAllDiary(String diaryId) async {
    final db = await DatabaseHandler.db(diaryTable);
    try {
      await db.delete(
          diaryTable);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  /// Hanlde doctor data
  static Future<void> insertDoctor(DoctorModel doctor) async {
    final db = await DatabaseHandler.db(doctorTable);
    await db.insert(
      doctorTable,
      doctor.toJson(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<DoctorModel>> getDoctors() async {
    final db = await DatabaseHandler.db(doctorTable);
    final List<Map<String, dynamic>> list = await db.query(doctorTable);
    return list.map((e) => DoctorModel.fromDatabase(e)).toList();
  }

  static Future<void> updateDoctor(DoctorModel doctor) async {
    final db = await DatabaseHandler.db(doctorTable);

    await db.update(
      doctorTable,
      doctor.toJson(),
      // Ensure that the Dog has a matching id.
      where: 'doctorId = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [doctor.doctorId],
    );
  }

  static Future<DoctorModel?> getDoctor(String doctorId) async {
    final db = await DatabaseHandler.db(doctorTable);
    final List<Map<String, dynamic>> maps = await db.query(doctorTable, where: 'doctorId = ?', whereArgs: [doctorId]);
    if (maps.isEmpty) {
      return null;
    }
    return DoctorModel.fromDatabase(maps.first);
  }

  static Future<void> updateDoctorList(List<DoctorModel> doctors) async {
    for (DoctorModel element in doctors) {
      String id = element.doctorId;
      DoctorModel? doctor = await DatabaseHandler.getDoctor(id);
      if (doctor != null) {
        DatabaseHandler.updateDoctor(element);
      } else {
        DatabaseHandler.insertDoctor(element);
      }
    }
  }

  static Future<void> deleteAllDoctors() async {
    final db = await DatabaseHandler.db(doctorTable);
    try {
      await db.delete(
          doctorTable
      );
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  /// Hanlde Vaccination data
  static Future<void> insertVaccination(VaccinationModel vaccination) async {
    final db = await DatabaseHandler.db(vaccinationTable);
    await db.insert(
      vaccinationTable,
      vaccination.toJson(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<VaccinationModel>> getVaccinationList() async {
    final db = await DatabaseHandler.db(vaccinationTable);
    final List<Map<String, dynamic>> list = await db.query(vaccinationTable);
    return list.map((e) => VaccinationModel.fromDatabase(e)).toList();
  }

  static Future<void> updateVaccination(VaccinationModel vaccination) async {
    final db = await DatabaseHandler.db(vaccinationTable);

    await db.update(
      vaccinationTable,
      vaccination.toJson(),
      // Ensure that the Dog has a matching id.
      where: 'vaccinationId = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [vaccination.vaccinationId],
    );
  }

  static Future<VaccinationModel?> getVaccination(String vaccinationId) async {
    final db = await DatabaseHandler.db(vaccinationTable);
    final List<Map<String, dynamic>> maps = await db.query(vaccinationTable, where: 'vaccinationId = ?', whereArgs: [vaccinationId]);
    if (maps.isEmpty) {
      return null;
    }
    return VaccinationModel.fromDatabase(maps.first);
  }

  static Future<void> deleteAllVaccination() async {
    final db = await DatabaseHandler.db(vaccinationTable);
    try {
      await db.delete(
          vaccinationTable
      );
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> updateVaccinationList(List<VaccinationModel> vaccinations) async {
    for (VaccinationModel element in vaccinations) {
      DatabaseHandler.insertVaccination(element);
    }
  }
}