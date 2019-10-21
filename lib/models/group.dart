import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

class Group {

  String id;
  String name;
  List<String> rescuersIds;

  Group(this.id, this.name, this.rescuersIds);

  Group.withName(this.name) {
    rescuersIds = new List();
  }

  int getMembersCount() {
    return rescuersIds.length;
  }

  Group.fromSnapshot(DataSnapshot snapshot) {
    id = snapshot.key;
    List<dynamic> rescuers = snapshot.value["rescuerIds"];
    rescuersIds = new List();
    if (rescuers != null) {
      rescuers.forEach((val) {
        rescuersIds.add(val.toString());
      });
    }
    name = snapshot.value["name"];

  }

  Group.fromMap(String key, Map map) {
    id = key;
    List<dynamic> rescuers = map["rescuerIds"];
    rescuersIds = new List();
    if (rescuers != null) {
      rescuers.forEach((val) {
        rescuersIds.add(val.toString());
      });
    }
    name = map["name"];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'rescuerIds': rescuersIds
    };
  }
}