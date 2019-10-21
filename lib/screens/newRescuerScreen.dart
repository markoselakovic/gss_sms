import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gss_sms/models/group.dart';
import 'package:gss_sms/models/rescuer.dart';
import 'package:gss_sms/util/repository.dart';

class NewRescuerScreen extends StatefulWidget {
  Rescuer _widgetRescuer;

  NewRescuerScreen() {
    _widgetRescuer = new Rescuer.Empty();
  }

  NewRescuerScreen.edit(Rescuer rescuer) {
    _widgetRescuer = rescuer;
  }

  @override
  _NewRescuerState createState() => _NewRescuerState(_widgetRescuer);
}

class _NewRescuerState extends State<NewRescuerScreen> {
  _NewRescuerState(Rescuer rescuer) {
    _formKey = GlobalKey<FormState>();
    _rescuer = rescuer;
    for (int i = 0; i < _groups.length; i++) {
      Group group = _groups[i];
      _enabledGroups[group] = group.rescuersIds.contains(_rescuer.gssId);
    }
  }

  var _formKey = GlobalKey<FormState>();
  Rescuer _rescuer;
  List<Group> _groups = Repository().getGroups();
  HashMap<Group, bool> _enabledGroups = new HashMap();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
            title: Text(
                _rescuer.gssId == null ? "Novi spasilac" : "Promena podataka")),
        body: new SingleChildScrollView(
            child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          behavior: HitTestBehavior.translucent,
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Ime'),
                            initialValue: _rescuer.name,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Ime mora biti popunjeno';
                              }
                            },
                            onSaved: (val) =>
                                setState(() => _rescuer.name = val),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Prezime'),
                            initialValue: _rescuer.lastName,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Prezime mora biti popunjeno';
                              }
                            },
                            onSaved: (val) =>
                                setState(() => _rescuer.lastName = val),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Nadimak'),
                            initialValue: _rescuer.nickname,
                            onSaved: (val) =>
                                setState(() => _rescuer.nickname = val),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'GSS ID'),
                            initialValue: _rescuer.gssId,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'GSS ID mora biti popunjen';
                              }
                            },
                            onSaved: (val) =>
                                setState(() => _rescuer.gssId = val),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Grad'),
                            initialValue: _rescuer.city,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Grad mora biti popunjen';
                              }
                            },
                            onSaved: (val) =>
                                setState(() => _rescuer.city = val),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Telefon'),
                            initialValue: _rescuer.phoneNumber,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Telefon mora biti popunjen';
                              }
                            },
                            onSaved: (val) =>
                                setState(() => _rescuer.phoneNumber = val),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                            child: Text('Lista grupa za slanje:'),
                          ),
                          getGroupsCheckBoxList(),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: RaisedButton(
                                  onPressed: () {
                                    final form = _formKey.currentState;
                                    if (form.validate()) {
                                      form.save();
                                      _saveRescuer(context);
                                    }
                                  },
                                  child: Text('Snimi spasioca'))),
                        ]))),
          ),
        )));
  }

  _saveRescuer(BuildContext context) {
    final rescuersReference = FirebaseDatabase.instance.reference();
    if (_rescuer.id == null){
      rescuersReference.child("rescuers").push().set(_rescuer.toJson()).then((_) {
        updateGroups(rescuersReference).then((_) {
          Navigator.pop(context);
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('Spasilac snjimljen')));
          });
      });
    } else {
      rescuersReference.child("rescuers")..child(_rescuer.id).update(_rescuer.toJson()).then((_) {
        updateGroups(rescuersReference).then((_)  {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('Podaci promenjeni')));
        });

      });
    }
  }

  Widget getGroupsCheckBoxList() {
    List<CheckboxListTile> children =
        List.generate(_enabledGroups.length, (index) {
      return CheckboxListTile(
        title: Text(_enabledGroups.keys.elementAt(index).name),
        value: _enabledGroups.values.elementAt(index),
        onChanged: (bool val) {
          setState(() {
            _enabledGroups[_enabledGroups.keys.elementAt(index)] = val;
          });
        },
      );
    });
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    ));
  }

  Future<void> updateGroups(DatabaseReference reference) {
    Map<String, dynamic> groupsToUpdate = HashMap();
    for (Group group in _enabledGroups.keys) {
      bool enabled = _enabledGroups[group];
      if  (enabled) {
        if (!group.rescuersIds.contains(_rescuer.gssId))  {
          group.rescuersIds.add(_rescuer.gssId);
          groupsToUpdate[group.id]  = group.toJson();
        }
      } else {
        if (group.rescuersIds.contains(_rescuer.gssId))  {
          group.rescuersIds.remove(_rescuer.gssId);
          groupsToUpdate[group.id]  = group.toJson();
        }
      }
    }
    return reference.child("groups").update(groupsToUpdate);
  }
}
