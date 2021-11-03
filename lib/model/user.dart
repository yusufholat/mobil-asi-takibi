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
    required this.vaccineID,
    required this.isVaccineted,
  });
  late final String vaccineID;
  late final bool isVaccineted;

  Vaccines.fromJson(Map<String, dynamic> json) {
    vaccineID = json['vaccineID'];
    isVaccineted = json['isVaccineted'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['vaccineID'] = vaccineID;
    _data['isVaccineted'] = isVaccineted;
    return _data;
  }
}
