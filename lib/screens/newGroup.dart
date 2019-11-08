import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gss_sms/models/group.dart';

class NewGroup extends StatefulWidget {
  @override
  _NewGroupState createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  final _formKey = GlobalKey<FormState>();
  String _groupName;

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
//                          () {
//                        Navigator.push(context, MaterialPageRoute(builder: (context) => GroupList(groups: _groups)));
//                      },
                                    ),
                              ),
                            ]))))));
  }

  void addGroup(String name, BuildContext context) {
    Group group = new Group.withName(name);
    final notesReference = FirebaseDatabase.instance.reference();
    notesReference.child("groups").push().set(group.toJson()).then((_) {
      Navigator.pop(context);
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Grupa je napravljena')));
    });
  }
}
