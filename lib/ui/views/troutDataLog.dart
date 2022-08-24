import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:ttlines2/ui/widgets/data_table.dart';

class TroutDataView extends StatefulWidget {
  TroutDataView({Key? key}) : super(key: key);

  @override
  State<TroutDataView> createState() => _TroutDataViewState();
}

class _TroutDataViewState extends State<TroutDataView> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final ButtonStyle style =
        TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    ElevatedButton.styleFrom(primary: Colors.cyan);
    return Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              icon: Icon(MaterialCommunityIcons.home)),
          title: Text(
            'TROUT DATA',
            style: theme.textTheme.headline5,
          ),
          actions: <Widget>[
            TextButton.icon(
              style: style,
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              icon: Icon(Icons.logout),
              label: Text('Sign Out'),
            ),
          ],
        ),
        body: Center(
            child: ListView(children: [
          SizedBox(height: 30),
          TroutDataTable(),
        ])));
  }
}
