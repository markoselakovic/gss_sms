import 'package:flutter/material.dart';
import 'package:gss_sms/screens/gssList.dart';
import 'package:gss_sms/screens/rescuerListState.dart';

class RescuerList extends GssList {

  RescuerList({Key key}) : super(key: key, title: "GSS Obavestenja");

  @override
  RescuerListState createState() => RescuerListState();

}