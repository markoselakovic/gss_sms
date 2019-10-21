import 'package:firebase_database/firebase_database.dart';

class Rescuer {

  String id;
  String gssId;
  String name;
  String lastName;
  String nickname;
  String phoneNumber;
  String city;

  Rescuer(this.gssId, this.name, this.lastName, this.nickname,
      this.phoneNumber, this.city);

  Rescuer.Empty();

  Rescuer.fromMap(String key, Map map)
      : id = key,
        gssId = map['gssId'],
        name = map['name'],
        lastName = map['lastName'],
        nickname = map['nickname'],
        phoneNumber = map['phoneNumber'],
        city = map['city'];

  Rescuer.fromSnapshot(DataSnapshot snapshot) :
        id = snapshot.key,
        gssId = snapshot.value['gssId'],
        name = snapshot.value['name'],
        lastName = snapshot.value['lastName'],
        nickname = snapshot.value['nickname'],
        phoneNumber = snapshot.value['phoneNumber'],
        city = snapshot.value['city'];

  Map<String, dynamic> toJson() =>
      {
        'gssId': gssId,
        'name': name,
        'lastName': lastName,
        'nickname': nickname,
        'phoneNumber': phoneNumber,
        'city': city,
      };
}