import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/add_contact_model.dart';

class DataBaseHelper {
  DataBaseHelper._();
  static final DataBaseHelper dataBaseHelper = DataBaseHelper._();
  Database? db;

  //Open Database
  Future<void> createDataBase() async {
    String drecotoryPath = await getDatabasesPath();
    String path = join(drecotoryPath, "ContactDairy.db");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String query =
            "CREATE TABLE IF NOT EXISTS contacts(contact_id INTEGER PRIMARY KEY AUTOINCREMENT,contact_name STRING,contact_number INTEGER);";
        await db.execute(query);

        log("----------------");
        log("Database created successfully");
        log("----------------");
      },
    );
  }

  //InsertContactInto Data Base
  Future<int> insertContact({required ContactModel contact}) async {
    if (db == null) {
      await createDataBase();
    }

    String query =
        "INSERT INTO contacts(contact_name,contact_number) VALUES(? ,?);";
    List args = [contact.name, contact.number];

    int? id = await db?.rawInsert(query, args);

    return id!;
  }

  //Fetch All Contacts
  Future<List<ContactModel>>? fetchAllContacts() async {
    if (db == null) {
      createDataBase();
    }

    String query = "SELECT * FROM contacts;";

    List<Map<String, dynamic>>? allContacts = await db?.rawQuery(query);
    log('--------------------');
    log('all:$allContacts');
    log('--------------------');
    List<ContactModel> con = allContacts!
        .map((e) => ContactModel.fromMap(
              data: e,
            ))
        .toList();
    log('--------------------');
    log('sep:$con');
    log('--------------------');
    return con;
  }
}
