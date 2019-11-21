import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:gss_sms/models/rescuer.dart';
import 'package:gss_sms/models/group.dart';
import 'package:gss_sms/screens/newGroup.dart';

class Repository {
  static final Repository _instance = Repository._internal();
  factory Repository() => _instance;

  DatabaseReference _rescuersReference;
  DatabaseReference _groupsReference;
  StreamController<List<Rescuer>> _rescuersStreamController;
  StreamController<List<Group>> _groupsStreamController;
  List<Rescuer> _rescuers;
  List<Group> _groups;

  Repository._internal() {
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    _rescuersReference = FirebaseDatabase.instance.reference().child('rescuers');
    _rescuersReference.onChildAdded.listen(_onRescuerAdded);
    _rescuersReference.onChildRemoved.listen(_onRescuerRemoved);
    _groupsReference = FirebaseDatabase.instance.reference().child("groups");
    _groupsReference.onChildAdded.listen(_onGroupsAdded);
    _groupsReference.onChildRemoved.listen(_onGroupRemoved);
    _rescuersStreamController = new StreamController.broadcast();
    _groupsStreamController = new StreamController.broadcast();
    _rescuers = new List();
    _groups = new List();
  }

  void fetchRescuers() async {
    List<Rescuer> rescuers = new List();
    await _rescuersReference.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> map = snapshot.value;
      for (int i = 0; i<map.length; i++) {
        String key = map.keys.elementAt(i);
        Map values = map.values.elementAt(i);
        rescuers.add(Rescuer.fromMap(key, values));
      }
    });
    _updateRescuers(rescuers);
  }

  void fetchGroups() async {
    List<Group> groups = new List();
//    Completer<List<Group>> completer = new Completer<List<Group>>();
    await _groupsReference.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> map = snapshot.value;
      for (int i = 0; i<map.length; i++) {
        String key = map.keys.elementAt(i);
        Map values = map.values.elementAt(i);
        groups.add(Group.fromMap(key, values));
      }
    });
    _updateGroups(groups);
  }

  Stream<List<Rescuer>> getRescuersStream() {
    return _rescuersStreamController.stream;
  }

  void _updateRescuers(List<Rescuer> rescuers) {
    _rescuers = rescuers;
    _rescuersStreamController.add(_rescuers);
  }

  _onRescuerAdded(Event event) {
    _rescuers.add(Rescuer.fromSnapshot(event.snapshot));
    _rescuersStreamController.add(_rescuers);
  }

  _onRescuerRemoved(Event event) {
    _rescuers.removeWhere((rescuer) => rescuer.id == event.snapshot.key);
    _rescuersStreamController.add(_rescuers);
  }

  List<Rescuer> getRescuers() {
    _rescuers.sort((a, b) => int.parse(a.gssId).compareTo(int.parse(b.gssId)));
    return _rescuers;
  }

  Stream<List<Group>> getGroupsStream() {
    return _groupsStreamController.stream;
  }

  List<Group> getGroups() {
    _groups.sort((a, b) => getPriorityRank(a.priority).compareTo(getPriorityRank(b.priority)));
    return _groups;
  }

  void _updateGroups(List<Group> groups) {
    _groups = groups;
    _groupsStreamController.add(_groups);
  }

  _onGroupsAdded(Event event) {
    _groups.add(Group.fromSnapshot(event.snapshot));
    _groupsStreamController.add(_groups);
  }

  _onGroupRemoved(Event event) {
    _groups.removeWhere((group) => group.id == event.snapshot.key);
    _groupsStreamController.add(_groups);
  }

 int getPriorityRank(String priority) {
    switch (priority) {
      case NIZAK: return 3;
      case SREDNJI: return 2;
      case VISOK: return 1;
    }
    return 3;
 }
}