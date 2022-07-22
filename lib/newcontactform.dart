import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_example1/models/contact.dart';

class NewContactForm extends StatefulWidget {
  const NewContactForm({Key? key}) : super(key: key);

  @override
  State<NewContactForm> createState() => _NewContactFormState();
}

class _NewContactFormState extends State<NewContactForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController numb = TextEditingController();
  TextEditingController name = TextEditingController();

  late String _name;
  late String _age;

  void addContact(Contact contact) {
    final contactsBox = Hive.box('contact');
    contactsBox.add(contact);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: name,
                  decoration: const InputDecoration(labelText: 'Name'),
                  onSaved: (value) => _name = value!,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  controller: numb,
                  decoration: const InputDecoration(
                      labelText: 'Age', hintText: 'Number only'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onSaved: (newValue) => _age = newValue!,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
                onPressed: () {
                  _formKey.currentState!.save();
                  final newContact = Contact(name: _name, age: int.parse(_age));
                  addContact(newContact);
                  numb.clear();
                  name.clear();
                },
                child: const Text("Add New Contact")),
          ),
        ],
      ),
    );
  }
}
