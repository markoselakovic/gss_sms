import 'package:flutter/material.dart';
import 'package:gss_sms/models/message.dart';
class SendMessage extends StatefulWidget {

  @override
  _SendMessageState createState() => _SendMessageState();
}

class _SendMessageState extends State {

  final _formKey = GlobalKey<FormState>();
  final _message = Message();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(title: Text('Profile')),
        body: Container(
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
                                setState(() => _message.message = val),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                            child: Text('Subscribe'),
                          ),
                          SwitchListTile(
                              title: const Text('Monthly Newsletter'),
                              value: true,
                              onChanged: (bool val) =>
                                  setState(() => _message.g1 = val)),
//                          Container(
//                            padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
//                            child: Text('Interests'),
//                          ),
//                          CheckboxListTile(
//                              title: const Text('Cooking'),
//                              value: _user.passions[User.PassionCooking],
//                              onChanged: (val) {
//                                setState(() =>
//                                _user.passions[User.PassionCooking] = val);
//                              }),
//                          CheckboxListTile(
//                              title: const Text('Traveling'),
//                              value: _user.passions[User.PassionTraveling],
//                              onChanged: (val) {
//                                setState(() => _user
//                                    .passions[User.PassionTraveling] = val);
//                              }),
//                          CheckboxListTile(
//                              title: const Text('Hiking'),
//                              value: _user.passions[User.PassionHiking],
//                              onChanged: (val) {
//                                setState(() =>
//                                _user.passions[User.PassionHiking] = val);
//                              }),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: RaisedButton(
                                  onPressed: () {
                                    final form = _formKey.currentState;
                                    if (form.validate()) {
                                      form.save();
                                      _showDialog(context);
                                      form.reset();
                                    }
                                  },
                                  child: Text('Save'))),
                        ])))));
  }
  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Poruka poslata')));
  }

}