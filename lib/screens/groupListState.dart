import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gss_sms/models/group.dart';
import 'package:gss_sms/screens/groupDetailsScreen.dart';
import 'package:gss_sms/screens/gssListState.dart';
import 'package:gss_sms/util/repository.dart';
import 'package:gss_sms/widgets/groupListItemWidget.dart';

import 'newGroup.dart';

class GroupListState extends GssListState {

  List<Group> _groups;

  GroupListState() {
    Repository repository = Repository();
    repository.getGroupsStream().listen((groups) {_updateGroups(groups);});
    _groups = Repository().getGroups();
  }

  @override
  Widget getListItemWidget(int index) {
    return GroupListItemWidget(_groups[index]);
  }

  @override
  int getListLength() {
    return _groups.length;
  }

  @override
  String getTitle() {
    return "Sve grupe";
  }

  @override
  void fabAction(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NewGroup()));
  }

  @override
  void onListItemClicked(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => GroupDetailsScreen(_groups[index]),
        ));
  }

  void _updateGroups(List<Group> groups) {
    setState(() {
      _groups = groups;
    });
  }

}