
class ExcretionModel {
  String excretionId = '${DateTime.now().microsecondsSinceEpoch}';
  String babyId = '${DateTime.now().microsecondsSinceEpoch}';
  int type = 0;
  String note = '';
  String url = '';
  DateTime time = DateTime.now();
  DateTime createdTime = DateTime.now();
  DateTime updatedTime = DateTime.now();

  ExcretionModel({
    required this.excretionId,
    required this.babyId,
    required this.type,
    required this.note,
    required this.url,
    required this.time,
    required this.createdTime,
    required this.updatedTime,
  });

  ExcretionModel.init() {
    excretionId = '${DateTime.now().microsecondsSinceEpoch}';
    babyId = '${DateTime.now().microsecondsSinceEpoch}';
    type = 0;
    note = '';
    url = '';
    time = DateTime.now();
    createdTime = DateTime.now();
    updatedTime = DateTime.now();
  }

  ExcretionModel.fromDatabase(Map<String, dynamic> json) {
    excretionId = json['excretionId'];
    babyId = json['babyId'];
    type = json['type'];
    note = json['note'];
    url = json['url'];
    time = DateTime.fromMicrosecondsSinceEpoch(json['time'] as int);
    createdTime = DateTime.fromMicrosecondsSinceEpoch(json['createdTime'] as int);
    updatedTime = DateTime.fromMicrosecondsSinceEpoch(json['updatedTime'] as int);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['excretionId'] = excretionId;
    data['babyId'] = babyId;
    data['type'] = type;
    data['note'] = note;
    data['url'] = url;
    data['time'] = time.microsecondsSinceEpoch;
    data['createdTime'] = createdTime.microsecondsSinceEpoch;
    data['updatedTime'] = updatedTime.microsecondsSinceEpoch;
    return data;
  }
}