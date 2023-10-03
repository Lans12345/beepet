import 'package:beepet/services/add_notif.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future addPet(name, breed, gender, birthday, myname) async {
  final docUser = FirebaseFirestore.instance.collection('Pets').doc();

  final json = {
    'name': name,
    'breed': breed,
    'gender': gender,
    'birthday': birthday,
    'dateTime': DateTime.now(),
    'myname': myname
  };

  addNotif('You have succesfully added a pet: $name', myname);

  await docUser.set(json);
}
