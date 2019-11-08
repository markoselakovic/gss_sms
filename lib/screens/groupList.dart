import 'package:flutter/material.dart';
import 'package:gss_sms/screens/gssList.dart';

import 'groupListState.dart';

class GroupList extends GssList {

  GroupList({Key key}) : super(key: key, title: "GSS Obavestenja - grupe");

  @override
  GroupListState createState() => GroupListState();

}