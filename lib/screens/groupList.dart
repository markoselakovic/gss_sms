import 'package:flutter/material.dart';
import 'package:gss_sms/screens/gssList.dart';
import 'package:gss_sms/models/group.dart';
import 'package:gss_sms/widgets/groupListItemWidget.dart';

class GroupList extends GssList {

  GroupList({Key key, this.groups}) : super(key: key, title: "GSS Obavestenja - grupe");

  final List<Group> groups;
  @override
  List getListItems() {
    return groups;
  }

  @override
  Widget getListItemWidget(int index) {
    return GroupListItemWidget(groups[index]);
  }

  @override
  int getListLength() {
    return groups.length;
  }

  @override
  String getTitle() {
    return "Sve grupe";
  }
}