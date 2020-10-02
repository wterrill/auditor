import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Contact.dart';

class HiveTest extends StatelessWidget {
  const HiveTest({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('hive test')),
        body: Column(
          children: [Expanded(child: _buildListView()), NewContactForm()],
        ));
  }
}

Widget _buildListView() {
  return ValueListenableBuilder(
    valueListenable: Hive.box<Contact>('contacts').listenable(),
    builder: (context, Box<Contact> contactsBox, _) {
      if (contactsBox.values.isEmpty) {
        return Text('data is empty');
      } else {
        return ListView.builder(
          itemCount: contactsBox.values.length,
          itemBuilder: (context, index) {
            var contact = contactsBox.getAt(index);
            return ListTile(
              title: Text(contact.name),
              subtitle: Text(contact.age.toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      contactsBox.putAt(
                          index, Contact('${contact.name}*', contact.age + 1));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      contactsBox.deleteAt(index);
                    },
                  )
                ],
              ),
            );
          },
        );
      }
    },
  );
}

class NewContactForm extends StatefulWidget {
  NewContactForm({Key key}) : super(key: key);

  @override
  _NewContactFormState createState() => _NewContactFormState();
}

class _NewContactFormState extends State<NewContactForm> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  String _age;

  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _ageController = new TextEditingController();

  void addContact(Contact contact) {
    print('Name: ${contact.name}, Age: ${contact.age}');
    final Box<Contact> contactsBox = Hive.box<Contact>('contacts');
    contactsBox.add(contact);
    print('----${contactsBox.get(contactsBox.length - 1).age}');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    onSaved: (value) {
                      _name = value;
                      _nameController.clear();
                    }),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                    controller: _ageController,
                    decoration: InputDecoration(labelText: 'age'),
                    onSaved: (value) {
                      _age = value;
                      _ageController.clear();
                    }),
              ),
            ],
          ),
          RaisedButton(
            child: Text("Add New Contact"),
            onPressed: () {
              _formKey.currentState.save();
              final newContact = Contact(_name, int.parse(_age));
              addContact(newContact);
              _name = "";
              _age = "";
            },
          )
        ],
      ),
    );
  }
}
