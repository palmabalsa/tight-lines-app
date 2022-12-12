import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ttlines2/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:ttlines2/ui/themes.dart';
import 'package:ttlines2/ui/views/confetti_screen.dart';
import 'package:ttlines2/ui/views/settings.dart';
import 'package:ttlines2/ui/views/tt.dart';
import 'package:ttlines2/ui/views/lake_omg.dart';
import 'package:ttlines2/ui/views/tt_webview.dart';
import 'package:ttlines2/ui/views/home.dart';
import 'package:ttlines2/ui/views/trout_data_log.dart';
// import 'package:ttlines2/ui/views/login_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  await Future.delayed(const Duration(milliseconds: 500));
  runApp(ProviderScope(child: MyApp()));
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
          '/confetti': (context) => ConfettiPlayer(),
          '/logsettings': (context) => const SettingsView(),
          '/sign-in': (context) {
            return SignInScreen(
              providers: [EmailAuthProvider()],
              actions: [
                AuthStateChangeAction<SignedIn>((context, state) {
                  Navigator.pushReplacementNamed(context, '/fishinglog');
                }),
                EmailLinkSignInAction((context) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const EmailLinkSignInScreen(),
                  ));
                }),
                ForgotPasswordAction((context, email) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ForgotPasswordScreen(),
                  ));
                })
              ],
            );
          },
        });
  }
}
