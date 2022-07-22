import 'package:flutter/material.dart';
import 'package:hive_example1/newcontactform.dart';
import 'package:hive_flutter/adapters.dart';

import 'models/contact.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive tutorial'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box('contact').listenable(),
              builder: (context, contact, _) => ListView.builder(
                itemCount: Hive.box('contact').length,
                itemBuilder: (context, index) {
                  final contact = Hive.box('contact').getAt(index) as Contact;
                  return ListTile(
                    title: Text(contact.name),
                    subtitle: Text(
                      contact.age.toString(),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                            onPressed: () {
                              Hive.box('contact').putAt(
                                  index,
                                  Contact(
                                      name: "${contact.name}*",
                                      age: contact.age + 1));
                            },
                            icon: const Icon(Icons.refresh)),
                        IconButton(
                            onPressed: () {
                              Hive.box('contact').deleteAt(index);
                            },
                            icon: const Icon(Icons.delete)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          const NewContactForm()
        ],
      ),
    );
  }
}

//  ListView.builder(
//       itemCount: contactsBox.length,
//       itemBuilder: (context, index) {
//         final contact = contactsBox.getAt(index) as Contact;
//         return const ListTile(
//           title: Text('name'),
//           subtitle: Text('Age'),
//         );
//       });
