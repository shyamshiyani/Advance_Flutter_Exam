import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDatabaseHelper {
  FirebaseDatabaseHelper._();
  static final FirebaseDatabaseHelper firebaseDatabaseHelper =
      FirebaseDatabaseHelper._();

  static final FirebaseFirestore db = FirebaseFirestore.instance;
  AddContact() async {
    db.collection("Backup_Contacts").get;
  }
}
