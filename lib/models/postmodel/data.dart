class Data {
  Data({
      this.data,});

  Data.fromJson(dynamic json) {
    data = json['data'];
  }
  String? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data;
    return map;
  }

}