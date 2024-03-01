import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: Center(
            child: ListView(
          children: <Widget>[
            const Divider(),
            // Text('Choose Form Fields:'),

            // profile settings - change email/password etc

            // fish form settings - change field options

            //log out

            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
              child: const Text('Sign Out'),
            ),
            const Divider(),
          ],
        )));
  }
}
