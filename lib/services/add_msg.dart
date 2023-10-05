import 'package:cloud_firestore/cloud_firestore.dart';

Future addMessage(desc, myname) async {
  final docUser = FirebaseFirestore.instance.collection('Messages').doc();

  final json = {'desc': desc, 'dateTime': DateTime.now(), 'myname': myname};

  await docUser.set(json);
}
