class Vaccine {
  late String name;
  late int dayCount;
  late String desc;
  Vaccine({name, dayCount, desc});

  Vaccine.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dayCount = json['dayCount'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['dayCount'] = this.dayCount;
    data['desc'] = this.desc;
    return data;
  }
}
