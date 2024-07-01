
class HeightModel {
  String heightId = '${DateTime.now().microsecondsSinceEpoch}';
  String babyId = '${DateTime.now().microsecondsSinceEpoch}';
  int height = 0;
  DateTime createdTime = DateTime.now();
  DateTime updatedTime = DateTime.now();
  DateTime time = DateTime.now();

  HeightModel({
    required this.heightId,
    required this.babyId,
    required this.height,
    required this.time,
    required this.createdTime,
    required this.updatedTime,
  });

  HeightModel.init() {
    babyId = '${DateTime.now().microsecondsSinceEpoch}';
    heightId = '${DateTime.now().microsecondsSinceEpoch}';
    height = 0;
    time = DateTime.now();
    createdTime = DateTime.now();
    updatedTime = DateTime.now();
  }

  HeightModel.fromDatabase(Map<String, dynamic> json) {
    babyId = json['babyId'];
    heightId = json['heightId'];
    height = json['height'];
    time = DateTime.fromMicrosecondsSinceEpoch(json['time'] as int);
    createdTime = DateTime.fromMicrosecondsSinceEpoch(json['createdTime'] as int);
    updatedTime = DateTime.fromMicrosecondsSinceEpoch(json['updatedTime'] as int);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['babyId'] = babyId;
    data['heightId'] = heightId;
    data['height'] = height;
    data['time'] = time.microsecondsSinceEpoch;
    data['createdTime'] = createdTime.microsecondsSinceEpoch;
    data['updatedTime'] = updatedTime.microsecondsSinceEpoch;
    return data;
  }
}