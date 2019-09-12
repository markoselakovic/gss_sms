class Group {

  String id;
  String name;
  List<String> rescuersIds;

  Group(this.id, this.name, this.rescuersIds);

  int getMembersCount() {
    return rescuersIds.length;
  }
}