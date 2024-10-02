import 'package:flutter/material.dart';
import 'package:app_contactos/models/contact.dart';
import 'package:app_contactos/page/contact_form.dart';
import 'package:app_contactos/page/home_page.dart';
import 'package:app_contactos/page/login_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mis Contactos',
      initialRoute: 'login',
      routes: {
        'home': (BuildContext context) => Home(contacts: []),
        'contactForm': (BuildContext context) => ContactForm(
              onContactAdded: (Contact newContact) {},
            ),
        'login': (BuildContext context) => const Login(),
      },
    );
  }
}
