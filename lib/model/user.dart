class DbUser {
  DbUser({
    required this.uid,
    required this.vaccines,
    required this.displayName,
    required this.email,
  });
  late final String uid;
  late final List<Vaccines> vaccines;
  late final String displayName;
  late final String email;

  DbUser.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    vaccines =
        List.from(json['vaccines']).map((e) => Vaccines.fromJson(e)).toList();
    displayName = json['displayName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uid'] = uid;
    _data['vaccines'] = vaccines.map((e) => e.toJson()).toList();
    _data['displayName'] = displayName;
    _data['email'] = email;
    return _data;
  }
}

class Vaccines {
  Vaccines({
    required this.isVaccineted,
    required this.dayCount,
    required this.vaccineName,
  });
  bool? isVaccineted;
  late final int dayCount;
  late final String vaccineName;

  Vaccines.fromJson(Map<String, dynamic> json) {
    isVaccineted = json['isVaccineted'];
    dayCount = json['dayCount'];
    vaccineName = json['vaccineName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['isVaccineted'] = isVaccineted;
    _data['dayCount'] = dayCount;
    _data['name'] = vaccineName;
    return _data;
  }
}
