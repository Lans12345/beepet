import 'package:cloud_firestore/cloud_firestore.dart';

Future addUser(username, contactNumber) async {
  final docUser = FirebaseFirestore.instance.collection('Users').doc();

  final json = {
    'username': username,
    'contactNumber': contactNumber,
    'dateTime': DateTime.now(),
  };

  await docUser.set(json);
}
