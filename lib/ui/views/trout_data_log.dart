import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:ttlines2/ui/widgets/data_table.dart';

class TroutDataView extends StatefulWidget {
  const TroutDataView({Key? key}) : super(key: key);

  @override
  State<TroutDataView> createState() => _TroutDataViewState();
}

class _TroutDataViewState extends State<TroutDataView> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              icon: const Icon(MaterialCommunityIcons.home)),
          title: Row(
            children: [
              Text(
                'Trout Data',
                style: theme.textTheme.headline5,
              ),
              const Spacer(),
              // replaced container w sizedbox (thanks dart)
              SizedBox(
                height: 40,
                width: 50,
                child:
                    Image.asset('assets/images/trout.png', color: Colors.white),
              ),
              const Spacer(flex: 6),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
        body: Center(
            child: ListView(children: const [
          SizedBox(height: 10),
          TroutDataTable(),
        ])));
  }
}
