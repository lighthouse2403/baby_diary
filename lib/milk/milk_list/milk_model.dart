enum MilkType {
  milk,
  motherMilk
}

class MilkModel {
  String milkId = '${DateTime.now().microsecondsSinceEpoch}';
  String babyId = '${DateTime.now().microsecondsSinceEpoch}';
  int type = 0;
  int quantity = 0;
  String note = '';
  String url = '';
  DateTime time = DateTime.now();
  DateTime createdTime = DateTime.now();
  DateTime updatedTime = DateTime.now();

  MilkModel({
    required this.milkId,
    required this.babyId,
    required this.type,
    required this.quantity,
    required this.note,
    required this.url,
    required this.time,
    required this.createdTime,
    required this.updatedTime,
  });

  MilkModel.init() {
    milkId = '${DateTime.now().microsecondsSinceEpoch}';
    babyId = '${DateTime.now().microsecondsSinceEpoch}';
    type = 0;
    quantity = 0;
    note = '';
    url = '';
    time = DateTime.now();
    createdTime = DateTime.now();
    updatedTime = DateTime.now();
  }

  MilkModel.fromDatabase(Map<String, dynamic> json) {
    milkId = json['milkId'];
    babyId = json['babyId'];
    quantity = json['quantity'];
    type = json['type'];
    note = json['note'];
    url = json['url'];
    time = DateTime.fromMicrosecondsSinceEpoch(json['time'] as int);
    createdTime = DateTime.fromMicrosecondsSinceEpoch(json['createdTime'] as int);
    updatedTime = DateTime.fromMicrosecondsSinceEpoch(json['updatedTime'] as int);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['milkId'] = milkId;
    data['babyId'] = babyId;
    data['type'] = type;
    data['quantity'] = quantity;
    data['note'] = note;
    data['url'] = url;
    data['time'] = time.microsecondsSinceEpoch;
    data['createdTime'] = createdTime.microsecondsSinceEpoch;
    data['updatedTime'] = updatedTime.microsecondsSinceEpoch;
    return data;
  }
}