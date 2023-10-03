import 'package:cloud_firestore/cloud_firestore.dart';

Future addNotif(name, myname) async {
  final docUser = FirebaseFirestore.instance.collection('Notifs').doc();

  final json = {'name': name, 'dateTime': DateTime.now(), 'myname': myname};

  await docUser.set(json);
}
