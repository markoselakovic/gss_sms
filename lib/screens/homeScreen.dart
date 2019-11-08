import 'package:flutter/material.dart';
import 'package:gss_sms/models/group.dart';
import 'package:gss_sms/models/rescuer.dart';
import 'package:gss_sms/screens/rescuerList.dart';
import 'package:gss_sms/screens/sendMessage.dart';
import 'package:gss_sms/util/repository.dart';
import 'package:gss_sms/screens/groupList.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  _HomeScreenState() {
    Repository repository = Repository();

    repository.getRescuersStream().listen((rescuers) {_updateRescuers(rescuers);});
    repository.getGroupsStream().listen((groups) {_updateGroups(groups);});
  }

  List<Group> _groups;
  List<Rescuer> _rescuers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("GSS obavestenja"),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    padding: EdgeInsets.all(5),
                    child: Text("Lista spasilaca", style: TextStyle(fontSize: 20.0),),
                    onPressed: _rescuers == null ? null : () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RescuerList()));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: RaisedButton(
                      padding: EdgeInsets.all(5),
                      child: Text("Lista grupa", style: TextStyle(fontSize: 20.0),),
                      onPressed: _groups == null ? null : () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GroupList()));
                      },
                    ),
                  ),
                  RaisedButton(
                    padding: EdgeInsets.all(5),
                    child: Text("Slanje poruka",style: TextStyle(fontSize: 20.0),),
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SendMessage()));},
                  ),
                ])));
  }

  void _updateGroups(List<Group> groups) {
    setState(() {
      _groups = groups;
    });
  }

  void _updateRescuers(List<Rescuer> rescuers) {
    setState(() {
      _rescuers = rescuers;
    });
  }

}