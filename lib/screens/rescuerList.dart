import 'package:flutter/material.dart';
import 'package:gss_sms/screens/gssList.dart';
import 'package:gss_sms/models/rescuer.dart';
import 'package:gss_sms/widgets/rescuerListItemWidget.dart';
class RescuerList extends GssList {

  RescuerList({Key key, this.rescuers}) : super(key: key, title: "GSS Obavestenja");
  final List<Rescuer> rescuers;
  @override
  List getListItems() {

    return rescuers;
  }

  @override
  Widget getListItemWidget(int index) {
    return RescuerListItemWidget(rescuers[index]);
  }

  @override
  int getListLength() {
    return rescuers.length;
  }

  @override
  String getTitle() {
    return "Lista svih spasilaca";
  }
}