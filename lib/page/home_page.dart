import 'package:app_contactos/models/contact.dart';
import 'package:app_contactos/page/contact_form.dart';
import 'package:app_contactos/page/login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(Home(contacts: []));

class Home extends StatefulWidget {
  final List<Contact> contacts;

  const Home({super.key, required this.contacts});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Home> {
  late List<Contact> _contact;
  List<Contact> _filteredContacts = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _contact = widget.contacts;
    _filteredContacts = _contact;
  }

  void _addContact(Contact newContact) {
    setState(() {
      _contact.add(newContact);
      _filteredContacts = _contact;
    });
  }

  void _deleteContact(int index) {
    setState(() {
      _contact.removeAt(index);
      _filteredContacts = _contact;
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  void _filterContacts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredContacts = _contact;
        _isSearching = false;
      } else {
        _filteredContacts = _contact
            .where((contact) =>
                contact.name.toLowerCase().contains(query.toLowerCase()) ||
                contact.lastname.toLowerCase().contains(query.toLowerCase()))
            .toList();
        _isSearching = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.yellow,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: _isSearching
              ? TextField(
                  onChanged: _filterContacts,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: 'Buscar Contacto...',
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none,
                  ),
                )
              : const Text('Agenda de Contacto'),
          backgroundColor: Colors.yellow,
          actions: [
            IconButton(
              icon: Icon(_isSearching ? Icons.clear : Icons.search),
              onPressed: () {
                setState(() {
                  if (_isSearching) {
                    _isSearching = false;
                    _filteredContacts = _contact;
                  } else {
                    _isSearching = true;
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: _logout,
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: _filteredContacts.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                  '${_filteredContacts[index].name} ${_filteredContacts[index].lastname}'),
              subtitle: Text(_filteredContacts[index].phone),
              leading: CircleAvatar(
                child: Text(_filteredContacts[index].name.substring(0, 1)),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _deleteContact(index);
                },
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactForm(
                  onContactAdded: _addContact,
                ),
              ),
            ).then((_) {
              setState(() {});
            });
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.yellow,
        ),
      ),
    );
  }
}
