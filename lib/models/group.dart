import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

class Group {

  String id;
  String name;
  List<String> rescuersIds;
  String priority;

  Group(this.name, this.priority) {
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
    priority = snapshot.value["priority"];
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
    priority = map["priority"];
    name = map["name"];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'rescuerIds': rescuersIds,
      'priority' : priority
    };
  }
}