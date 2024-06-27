
class BabyInformationModel {
  String babyId = '${DateTime.now().microsecondsSinceEpoch}';
  String babyName = '';
  int gender = 0;
  DateTime birthDate = DateTime.now();
  DateTime createdTime = DateTime.now();
  DateTime updatedTime = DateTime.now();

  BabyInformationModel({
    required this.babyId,
    required this.babyName,
    required this.gender,
    required this.birthDate,
    required this.createdTime,
    required this.updatedTime,
  });

  BabyInformationModel.init() {
    babyId = '${DateTime.now().microsecondsSinceEpoch}';
    babyName = '';
    gender = 0;
    birthDate = DateTime.now();
    createdTime = DateTime.now();
    updatedTime = DateTime.now();
  }

  BabyInformationModel.fromDatabase(Map<String, dynamic> json) {
    babyId = json['babyId'];
    babyName = json['babyName'];
    gender = json['gender'];
    birthDate = DateTime.fromMicrosecondsSinceEpoch(json['birthDate'] as int);
    createdTime = DateTime.fromMicrosecondsSinceEpoch(json['createdTime'] as int);
    updatedTime = DateTime.fromMicrosecondsSinceEpoch(json['updatedTime'] as int);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['babyId'] = babyId;
    data['babyName'] = babyName;
    data['gender'] = gender;
    data['birthDate'] = birthDate.microsecondsSinceEpoch;
    data['createdTime'] = createdTime.microsecondsSinceEpoch;
    data['updatedTime'] = updatedTime.microsecondsSinceEpoch;
    return data;
  }
}