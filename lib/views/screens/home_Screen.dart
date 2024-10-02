import 'dart:developer';

import 'package:contact_dairy_app/models/add_contact_model.dart';
import 'package:contact_dairy_app/utils/Helpers/dataBase_Helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    DataBaseHelper.dataBaseHelper.createDataBase();
  }

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController contactNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  String? name;
  String? number;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Dairy"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "Backup_Screen");
              },
              icon: const Icon(Icons.backup_rounded)),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Add Contact"),
                    content: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Enter Contact Name"),
                            const SizedBox(height: 08),
                            TextFormField(
                              onSaved: (val) {
                                name = val;
                              },
                              validator: (val) {
                                if (val == null) {
                                  return "Enter the name...";
                                }
                                return null;
                              },
                              controller: contactNameController,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter Name",
                                label: Text("Name"),
                              ),
                            ),
                            const SizedBox(height: 08),
                            const Text("Enter Contact Number"),
                            const SizedBox(height: 08),
                            TextFormField(
                              onSaved: (val) {
                                number = val;
                              },
                              validator: (val) {
                                if (val == null) {
                                  return "Enter the number...";
                                }
                                return null;
                              },
                              controller: contactNumberController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter Number",
                                label: Text("Number"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          contactNameController.clear();
                          contactNumberController.clear();
                          name = null;
                          number = null;
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            ContactModel contact =
                                ContactModel(name: name!, number: number!);
                            DataBaseHelper.dataBaseHelper
                                .insertContact(contact: contact);
                            log("-----------");
                            log(contact.name);
                            log(contact.number);
                            log("-----------");
                            contactNameController.clear();
                            contactNumberController.clear();
                            name = null;
                            number = null;
                            Navigator.pop(context);

                            setState(() {
                              DataBaseHelper.dataBaseHelper.fetchAllContacts();
                            });
                          }
                        },
                        child: const Text("Save"),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
          child: FutureBuilder(
              future: DataBaseHelper.dataBaseHelper.fetchAllContacts(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  List<ContactModel>? data = snapshot.data;
                  return Center(child: Text("Error:${snapshot.error}"));
                } else if (snapshot.hasData) {
                  List<ContactModel>? data = snapshot.data;

                  return (data!.isEmpty)
                      ? const Text("No Data Found")
                      : ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Text("${data[index]}"),
                              title: Text("${data[index + 1].number}"),
                              subtitle: Text("${data[index + 1].name}"),
                            );
                          },
                        );
                }
                return const Center(child: CircularProgressIndicator());
              })),
    );
  }
}
