import 'package:baby_diary/baby_information/baby_information_model.dart';
import 'package:baby_diary/excretion/excretion_list/excretion_model.dart';
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
  static String excretionTable = 'excretion';
  static String sleepTable = 'sleep';
  static String heightTable = 'height';
  static String weightTable = 'weight';
  static String milkTable = 'milkTable';
  static String motherMilkTable = 'motherMilk';
  static String eatingTable = 'eating';
  static String otherTable = 'other';

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
    await database.execute("CREATE TABLE $doctorTable(doctorId TEXT PRIMARY KEY, name TEXT, address TEXT, time TEXT, hospital TEXT, phone INTEGER, description TEXT, rate TEXT, view INTEGER)");
    await database.execute("CREATE TABLE $diaryTable(diaryId TEXT PRIMARY KEY, title TEXT, content TEXT, time INTEGER, createdTime INTEGER, updatedTime INTEGER, mediaUrl TEXT)");
    await database.execute("CREATE TABLE $vaccinationTable(vaccinationId TEXT PRIMARY KEY, name TEXT, address TEXT, time TEXT, phone INTEGER, rate TEXT, view INTEGER)");
    await database.execute("CREATE TABLE $notificationsTable(notificationId TEXT PRIMARY KEY, title TEXT, time INTEGER, createdTime INTEGER, updatedTime INTEGER, url TEXT, content TEXT)");

    await database.execute("CREATE TABLE $excretionTable(excretionId TEXT PRIMARY KEY, babyId TEXT, type INTEGER, note TEXT, time INTEGER, createdTime INTEGER, updatedTime INTEGER, url TEXT)");
    await database.execute("CREATE TABLE $sleepTable(sleepId TEXT PRIMARY KEY, babyId TEXT, startTime INTEGER, createdTime INTEGER, updatedTime INTEGER, duration INTEGER, startTime INTEGER)");
    await database.execute("CREATE TABLE $heightTable(heightId TEXT PRIMARY KEY, babyId TEXT, height INTEGER, note TEXT, createdTime INTEGER, updatedTime INTEGER, time INTEGER, url TEXT)");
    await database.execute("CREATE TABLE $weightTable(weightId TEXT PRIMARY KEY, babyId TEXT, weight INTEGER, note TEXT, time INTEGER, createdTime INTEGER, updatedTime INTEGER, url TEXT)");
    await database.execute("CREATE TABLE $milkTable(milkId TEXT PRIMARY KEY, babyId TEXT, quantity INTEGER, time INTEGER, createdTime INTEGER, updatedTime INTEGER, note TEXT, type INTEGER, url TEXT)");
    await database.execute("CREATE TABLE $motherMilkTable(motherMilkId TEXT PRIMARY KEY, babyId TEXT, left_quantity INTEGER, right_quantity INTEGER, time INTEGER, createdTime INTEGER, updatedTime INTEGER, note TEXT, duration INTEGER, url TEXT)");
    await database.execute("CREATE TABLE $eatingTable(eatingId TEXT PRIMARY KEY, babyId TEXT, quantity INTEGER, unit TEXT, time INTEGER, createdTime INTEGER, updatedTime INTEGER, note TEXT, duration INTEGER, url TEXT)");
    await database.execute("CREATE TABLE $otherTable(other TEXT PRIMARY KEY, babyId TEXT, quantity INTEGER, unit TEXT, time INTEGER, createdTime INTEGER, updatedTime INTEGER, note TEXT, duration INTEGER, url TEXT)");
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

  /// ---------------------- Hanlde doctor data --------------------------------
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

  /// ---------------------- Handle diaries table ------------------------------
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

  /// ------------------- Hanlde Vaccination data ------------------------------
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

  /// ------------------ Handle Baby weight ------------------------------------
  static Future<void> insertExcretion(ExcretionModel excretion) async {
    final db = await DatabaseHandler.db(excretionTable);
    await db.insert(
      excretionTable,
      excretion.toJson(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<ExcretionModel> getExcretion(String id) async {
    final db = await DatabaseHandler.db(excretionTable);
    final List<Map<String, dynamic>> maps = await db.query(excretionTable, where: 'excretionId = ?', whereArgs: [id]);
    return ExcretionModel.fromDatabase(maps.first);
  }

  static Future<List<ExcretionModel>> getAllxcretion() async {
    final db = await DatabaseHandler.db(excretionTable);
    final List<Map<String, dynamic>> list = await db.query(excretionTable);
    return list.map((e) => ExcretionModel.fromDatabase(e)).toList();
  }

  // Update an item by id
  static Future<void> updateExcretion(ExcretionModel excretion) async {
    final db = await DatabaseHandler.db(excretionTable);

    await db.update(
      excretionTable,
      excretion.toJson(),
      // Ensure that the Dog has a matching id.
      where: 'excretionId = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [excretion.excretionId],
    );
  }

  // Delete
  static Future<void> deleteExcretion(String excretionId) async {
    final db = await DatabaseHandler.db(excretionTable);
    try {
      await db.delete(
          excretionTable,
          where: "excretionId = ?",
          whereArgs: [excretionId]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> deleteAllExcretion() async {
    final db = await DatabaseHandler.db(excretionTable);
    try {
      await db.delete(
          excretionTable
      );
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}