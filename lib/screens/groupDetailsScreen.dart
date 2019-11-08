import 'package:flutter/material.dart';
import 'package:gss_sms/models/group.dart';
import 'package:gss_sms/models/rescuer.dart';
import 'package:gss_sms/util/repository.dart';
import 'package:gss_sms/widgets/rescuerListItemWidget.dart';

class GroupDetailsScreen extends StatelessWidget {

  GroupDetailsScreen(Group group) {
    _group = group;
    List<Rescuer> rescuers = Repository().getRescuers();
    for (int i=0; i < group.getMembersCount();i++) {
      for (int j=0; j < rescuers.length; j++) {
        if (group.rescuersIds[i] == rescuers[j].gssId) {
          _rescuersInGroup.add(rescuers[j]);
        }
      }
    }
  }


  Group _group;
  final List<Rescuer> _rescuersInGroup = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(_group.name),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 8),
              child: Text("Clanovi grupe",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _rescuersInGroup.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Container(
                        color: Colors.blue[300],
                        child: Center(child: RescuerListItemWidget(_rescuersInGroup[index])),
                      ),
//                      onTap: () =>
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                builder: (BuildContext context) => SendMessage(),
//                              )),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

}