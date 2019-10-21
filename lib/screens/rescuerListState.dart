import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gss_sms/models/rescuer.dart';
import 'package:gss_sms/screens/gssListState.dart';
import 'package:gss_sms/screens/newRescuerScreen.dart';
import 'package:gss_sms/util/repository.dart';
import 'package:gss_sms/widgets/rescuerListItemWidget.dart';

class RescuerListState extends GssListState {

  List<Rescuer> _rescuers;

  RescuerListState() {
    Repository repository = Repository();
    repository.getRescuersStream().listen((rescuers) {_updateRescuers(rescuers);});
    _rescuers = Repository().getRescuers();
  }

  @override
  Widget getListItemWidget(int index) {
    return RescuerListItemWidget(_rescuers[index]);
  }

  @override
  int getListLength() {
    return _rescuers.length;
  }

  @override
  String getTitle() {
    return "Lista svih spasilaca";
  }

  @override
  void fabAction(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NewRescuerScreen()));
  }

  @override
  void onListItemClicked(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => NewRescuerScreen.edit(_rescuers[index]),
        ));
  }

  void _updateRescuers(List<Rescuer> rescuers) {
    setState(() {
      _rescuers = rescuers;
    });
  }
}