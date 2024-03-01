import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:ttlines2/ui/views/settings.dart';
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
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
              icon: const Icon(MaterialCommunityIcons.home)),
          title: Row(
            children: [
              Text(
                'Trout Data',
                style: theme.textTheme.headlineSmall,
              ),
              const Spacer(),
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
            // settings button:::
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsView()),
                  );
                },
                icon: const Icon(
                  MaterialCommunityIcons.settings,
                  color: Colors.white,
                )),
          ],
        ),
        body: Center(
            child: ListView(children: const [
          SizedBox(height: 10),
          TroutDataTable(),
        ])));
  }
}
