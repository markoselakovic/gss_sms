import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gss_sms/models/group.dart';
import 'package:gss_sms/models/rescuer.dart';
import 'package:gss_sms/util/repository.dart';
import 'package:flutter_sms/flutter_sms.dart';

class SendMessage extends StatefulWidget {

  @override
  _SendMessageState createState() => _SendMessageState();
}

class _SendMessageState extends State {

  final _formKey = GlobalKey<FormState>();
  String _message;
  List<Group> _groups = Repository().getGroups();
  final HashMap<Group, bool> _enabledGroups = new HashMap();

  _SendMessageState() {
    _setInitialGroupValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(title: Text('Slanje poruka')),
        body:
        GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            behavior: HitTestBehavior.translucent,
            child: SingleChildScrollView(
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
                                    minLines: 4,
                                    maxLines: 6,
                                    decoration:
                                    InputDecoration(labelText: 'Ukucaj poruku'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Poruka je prazna';
                                      }
                                    },
                                    onSaved: (val) =>
                                        setState(() => _message = val),
                                  ),

                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0, horizontal: 16.0),
                                      child: _getGroupsCheckBoxList()),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0, horizontal: 16.0),
                                      child: RaisedButton(
                                          onPressed: () {
                                            final form = _formKey.currentState;
                                            if (form.validate()) {
                                              form.save();
                                              _sendMessage(context);
                                              _setInitialGroupValues();
                                              form.reset();
                                            }
                                          },
                                          child: Text('Posalji poruku'))),
                                ])))),
              ),
        )


    );
  }

  _sendMessage(BuildContext context) {
    List<String> numbers = _getPhoneNumbers();
    _sendSMS(_message, numbers);
  }

  void _sendSMS(String message, List<String> recipients) async {
    String _result = await FlutterSms
        .sendSMS(message: message, recipients: recipients)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  void _setInitialGroupValues()  {
    for (int i = 0; i < _groups.length; i++) {
      Group group = _groups[i];
      _enabledGroups[group] = false;
    }
  }

  List<String> _getPhoneNumbers() {
    List<String> ids  = List();
    List<Rescuer> rescuers = Repository().getRescuers();
    for (Group  group in _enabledGroups.keys) {
      if (_enabledGroups[group]) {
        for (String number in group.rescuersIds) {
          if (!ids.contains(number)) {
            ids.add(number);
          }

        }
      }
    }
    List<String> numbers = List();
    for (String id in ids) {
      for (Rescuer r in rescuers) {
        if (r.gssId == id) numbers.add(r.phoneNumber);
      }
    }
    return numbers;
  }

  Widget _getGroupsCheckBoxList() {
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

}