import 'package:firebase_core/firebase_core.dart';
import 'package:ttlines2/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:ttlines2/ui/themes.dart';
import 'package:ttlines2/ui/views/confetti_screen.dart';

import 'package:ttlines2/ui/views/tt.dart';
import 'package:ttlines2/ui/views/lake_omg.dart';
import 'package:ttlines2/ui/views/tt_webview.dart';

import 'package:ttlines2/ui/views/home.dart';

import 'package:ttlines2/ui/views/trout_data_log.dart';
import 'package:ttlines2/ui/views/login_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Future.wait([
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Future.delayed(const Duration(milliseconds: 500));
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Turangi Tight Lines',
        theme: Themes.light,
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (context) => const HomeView(),
          '/taurangataupo': (context) => const TaurangaTaupoView(),
          '/tt_level': (context) => const TTWebview(),
          '/lakeO': (context) => const LakeOmgView(),
          '/fishinglog': (context) => const TroutDataView(),
          '/login': (context) => const LoginView(),
          '/confetti': (context) => ConfettiPlayer(),
        });
  }
}
