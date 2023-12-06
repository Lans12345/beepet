import 'package:cloud_firestore/cloud_firestore.dart';

Future addUser(username, contactNumber, address) async {
  final docUser = FirebaseFirestore.instance.collection('Users').doc();

  final json = {
    'username': username,
    'contactNumber': contactNumber,
    'dateTime': DateTime.now(),
    'address': address,
    'profile': '',
    'uid': docUser.id
  };

  await docUser.set(json);
}
