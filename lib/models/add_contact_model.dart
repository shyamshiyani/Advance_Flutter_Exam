class ContactModel {
  String name;
  String number;

  ContactModel({required this.name, required this.number});
  factory ContactModel.fromMap({required data}) {
    return ContactModel(
        name: data['contact_name'], number: data['contact_number']);
  }
}
