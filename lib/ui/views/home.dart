import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:ttlines2/ui/views/Lake_Omg.dart';
import 'package:ttlines2/ui/views/TT.dart';
import 'package:ttlines2/ui/views/Tongariro.dart';
import 'package:ttlines2/ui/views/troutDataLog.dart';
import 'package:ttlines2/ui/widgets/RiverDropDownMenu.dart';
import 'package:ttlines2/ui/widgets/RiverLevelCard.dart';
import 'package:ttlines2/ui/widgets/RiverTitleAndWeatherButton.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ttlines2/ui/widgets/data_table.dart';
import 'package:ttlines2/ui/views/login_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController tabbarcontroller;

  @override
  void initState() {
    super.initState();
    tabbarcontroller = TabController(length: 3, vsync: this);
    initializeDateFormatting();
  }

  @override
  void dispose() {
    tabbarcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    final ButtonStyle logbuttonstyle = TextButton.styleFrom(
        primary: Colors.tealAccent,
        backgroundColor: Colors.tealAccent,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)));
    ElevatedButton.styleFrom(primary: Colors.amber);

    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
          title: Text(
            'TURANGI TIGHT LINES',
            style: theme.textTheme.headline5,
          ),
          actions: <Widget>[
            TextButton(
                style: logbuttonstyle,
                onPressed: () {
                  FirebaseAuth.instance.authStateChanges().listen((User? user) {
                    if (user == null) {
                      Navigator.pushNamed(context, '/login');
                    } else {
                      Navigator.pushNamed(context, '/fishinglog');
                    }
                  });
                },
                child: Text('LOG', style: theme.textTheme.bodyText2)),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: TabBar(
              controller: tabbarcontroller,
              labelStyle: TextStyle(fontSize: 16.0),
              // labelColor: Colors.amber,
              unselectedLabelStyle: TextStyle(fontSize: 12),
              // unselectedLabelColor: Colors.teal,
              tabs: <Widget>[
                Tab(text: 'TONGARIRO'),
                Tab(text: 'LAKE O'),
                Tab(text: 'TT'),
              ],
            ),
          )),
      body: Center(
          child: TabBarView(
        controller: tabbarcontroller,
        children: <Widget>[
          TongariroView(),
          LakeOmgView(),
          TaurangaTaupoView(),
        ],
      )),
    );
  }
}
