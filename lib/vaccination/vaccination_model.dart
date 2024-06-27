
class VaccinationModel {
  String? vaccinationId = '';
  String name = '';
  String address = '';
  String? time = '';
  String? phone = '';
  List<int>? rate = [];
  int? view = 0;

  VaccinationModel({
    required this.vaccinationId,
    required this.name,
    required this.address,
    required this.time,
    this.phone,
    this.rate,
    this.view,
  });

  VaccinationModel.fromJson(Map<String, dynamic> json) {
    vaccinationId = json['vaccinationId'] ?? '';
    name = json['name'] ?? '';
    address = json['address'] ?? '';
    time = json['time']?? '';
    phone = json['phone'] ?? '';
    if (json['rate'] != null) {
      rate = List.from(json['rate']);
    }
    view = json['view'] ?? 0;
  }

  VaccinationModel.fromDatabase(Map<String, dynamic> json) {
    vaccinationId = json['vaccinationId'] ?? '';
    name = json['name'] ?? '';
    address = json['address'] ?? '';
    time = json['time']?? '';
    phone = json['phone'] ?? '';
    view = json['view'] ?? 0;

    String rates = json['rate'] ?? '';
    if (rates.isEmpty) {
      return;
    }

    if (rates.contains('--')) {
      List<String> ratesString = rates.split('--');
      rate = ratesString.map((e) => int.parse(e)).toList();
    } else {
      rate = [int.parse(rates ?? '')];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vaccinationId'] = vaccinationId;
    data['name'] = name;
    data['time'] = time;
    data['view'] = view;
    data['address'] = address;
    int firstRate = rate?.firstOrNull ?? 0;
    List<int> rates = rate ?? [];
    if (rates.length > 1) {
      data['rate'] = rates.join('--');
    } else {
      data['rate'] = '$firstRate';
    }
    return data;
  }
}