class IndexModel {
  int id;
  String? week;
  String? bpdAverage;
  String? bpdRange;
  String? flAverage;
  String? flRange;
  String? efwAverage;
  String? efwRange;

  IndexModel({
    required this.id,
    this.week,
    this.bpdAverage,
    this.bpdRange,
    this.flAverage,
    this.flRange,
    this.efwAverage,
    this.efwRange,
  });

  factory IndexModel.fromJson(Map<String, dynamic> json) => IndexModel(
    id: json["id"] ?? 0,
    week: json["week"] ?? '',
    bpdAverage: json["bpd_tb"] ?? '',
    bpdRange: json["bpd_gh"] ?? '',
    flAverage: json["fl_tb"] ?? '',
    flRange: json["fl_gh"] ?? '',
    efwAverage: json["efw_tb"] ?? '',
    efwRange: json["efw_gh"] ?? '',
  );
}