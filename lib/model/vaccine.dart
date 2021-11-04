class Vaccine {
  late String name;
  late int dayCount;
  Vaccine({name, dayCount});

  Vaccine.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dayCount = json['dayCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
