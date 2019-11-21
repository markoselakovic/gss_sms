import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gss_sms/models/group.dart';

const String NIZAK = "nizak";
const String SREDNJI = "srednji";
const String VISOK = "visok";

class NewGroup extends StatefulWidget {
  @override
  _NewGroupState createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  final _formKey = GlobalKey<FormState>();
  String _groupName;
  List<String> priority = <String>[NIZAK, SREDNJI, VISOK];
  String priorityValue = "nizak";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(title: Text('Slanje poruka')),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            behavior: HitTestBehavior.translucent,
            child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Builder(
                    builder: (context) => Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFormField(
                                minLines: 4,
                                maxLines: 6,
                                decoration:
                                    InputDecoration(labelText: 'Ime grupe'),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Ime mora biti definisano';
                                  }
                                },
                                onSaved: (val) =>
                                    setState(() => _groupName = val),
                              ),
                              Row(
                                children: <Widget>[
                                  Text("Prioritet: "),
                                  DropdownButton<String>(
                                    value: priorityValue,
                                    icon: Icon(Icons.arrow_downward),
                                    hint: Text("Prioritet"),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(color: Colors.blueAccent[400]),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.blueAccent[400],
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        priorityValue = newValue;
                                      });
                                    },
                                    items: priority.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: RaisedButton(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "Dodaj grupu",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    onPressed: () {
                                      final form = _formKey.currentState;
                                      if (form.validate()) {
                                        form.save();
                                        addGroup(_groupName, context);
                                        form.reset();
                                      }
                                    }
                                    ),
                              ),
                            ]))))));
  }

  void addGroup(String name, BuildContext context) {
    Group group = new Group(name, priorityValue);
    final notesReference = FirebaseDatabase.instance.reference();
    notesReference.child("groups").push().set(group.toJson()).then((_) {
      Navigator.pop(context);
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Grupa je napravljena')));
    });
  }
}
