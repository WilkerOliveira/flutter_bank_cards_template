import 'package:meta/meta.dart';

class Storage {
  @required
  String name;

  dynamic value;

  Storage(this.name, this.value);

  Storage.fromDb(Map<String, dynamic> map)
      : name = map['name'],
        value = map['value'];

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map['name'] = name;
    map['value'] = value;

    return map;
  }
}