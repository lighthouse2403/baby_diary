
class BabyWeight {
  String babyWeightId = '${DateTime.now().microsecondsSinceEpoch}';
  int weight = 0;
  String note = '';
  DateTime time = DateTime.now();
  DateTime createdTime = DateTime.now();
  DateTime updatedTime = DateTime.now();

  BabyWeight({
    required this.babyWeightId,
    required this.weight,
    required this.time,
    required this.createdTime,
    required this.updatedTime,
  });

  BabyWeight.init() {
    babyWeightId = '${DateTime.now().microsecondsSinceEpoch}';
    weight = 0;
    note = '';
    time = DateTime.now();
    createdTime = DateTime.now();
    updatedTime = DateTime.now();
  }

  BabyWeight.fromDatabase(Map<String, dynamic> json) {
    babyWeightId = json['babyWeightId'];
    weight = json['weight'];
    note = json['note'];
    time = DateTime.fromMicrosecondsSinceEpoch(json['time'] as int);
    createdTime = DateTime.fromMicrosecondsSinceEpoch(json['createdTime'] as int);
    updatedTime = DateTime.fromMicrosecondsSinceEpoch(json['updatedTime'] as int);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['babyWeightId'] = babyWeightId;
    data['weight'] = weight;
    data['note'] = note;
    data['time'] = time.microsecondsSinceEpoch;
    data['createdTime'] = createdTime.microsecondsSinceEpoch;
    data['updatedTime'] = updatedTime.microsecondsSinceEpoch;
    return data;
  }
}