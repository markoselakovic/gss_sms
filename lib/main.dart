import 'package:flutter/material.dart';
import 'dart:developer';
import 'screens/rescuerList.dart';
import 'package:gss_sms/models/rescuer.dart';
import 'package:gss_sms/models/group.dart';
import 'screens/groupList.dart';
import 'package:gss_sms/screens/sendMessage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Rescuer rescuer = Rescuer("1", "792", "Marko", "Selakovic", "Selak", "063619775", "Belgrade");
  Rescuer rescuer2 = Rescuer("2", "792", "Petar", "Selakovic", "Pera", "063619775", "Belgrade");



  @override
  Widget build(BuildContext context) {
    final List<String> list =  new List();
    list.add("1");
    list.add("2");

    Group group = new Group("1", "Stanica Beograd", list);
    List<Group> groups = new List();
    groups.add(group);
    List<Rescuer> rescuers = List<Rescuer>();
    rescuers.add(rescuer);
    rescuers.add(rescuer2);
    return MaterialApp(
      title: 'GSS',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
//      home: RescuerList(rescuers: rescuers),
//      home: GroupList(groups: groups),
      home: SendMessage(),
    );
  }
}

