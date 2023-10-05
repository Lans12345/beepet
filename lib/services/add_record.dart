import 'package:beepet/services/add_notif.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future addRecord(petname, disease, treatment, medicine, pric, petid) async {
  final docUser = FirebaseFirestore.instance.collection('Records').doc();

  final json = {
    'petname': petname,
    'disease': disease,
    'treatment': treatment,
    'medicine': medicine,
    'pric': pric,
    'petid': petid,
    'dateTime': DateTime.now(),
  };

  addNotif('You have added a medical record for $petname', '');

  await docUser.set(json);
}
