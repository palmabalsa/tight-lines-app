import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ttlines2/ui/views/lake_omg.dart';
import 'package:ttlines2/ui/views/taupo_view.dart';
import 'package:ttlines2/ui/views/tt.dart';
import 'package:ttlines2/ui/views/tongariro.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController tabbarcontroller;

  @override
  void initState() {
    super.initState();
    tabbarcontroller = TabController(length: 4, vsync: this);
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
    return Scaffold(
      appBar: AppBar(
          title: Row(children: [
            Text(
              'Taupo Tight Lines',
              style: theme.textTheme.headlineSmall,
            ),
            Platform.isAndroid ? const Spacer(flex: 2) : const Spacer(),
            SizedBox(
              height: 40,
              width: 50,
              child:
                  Image.asset('assets/images/trout.png', color: Colors.white),
            ),
            const Spacer(flex: 6),
          ]),
          actions: <Widget>[
            Column(children: <Widget>[
              ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(0.0)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(99))),
                    side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(color: Colors.black, width: 0.5)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.teal.shade50),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {
                    FirebaseAuth.instance
                        .authStateChanges()
                        .listen((User? user) {
                      if (user == null) {
                        Navigator.pushNamed(context, '/sign-in');
                      } else {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/fishinglog', (route) => false);
                      }
                    });
                  },
                  child: const Text('LOG')),
              const Spacer(),
            ])
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: TabBar(
              controller: tabbarcontroller,
              tabs: const <Widget>[
                Tab(text: 'Tongariro'),
                Tab(text: 'Lake O'),
                Tab(text: 'TT'),
                Tab(text: 'Taupo'),
              ],
            ),
          )),
      body: Center(
          child: TabBarView(
        controller: tabbarcontroller,
        children: const <Widget>[
          TongariroView(),
          LakeOmgView(),
          TaurangaTaupoView(),
          TaupoView(),
        ],
      )),
    );
  }
}
