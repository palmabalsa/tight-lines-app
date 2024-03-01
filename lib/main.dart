import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth_platform_interface/src/auth_provider.dart'
    as FirebaseAuthProvider;
import 'package:firebase_ui_auth/src/providers/auth_provider.dart'
    as FirebaseUIAuthProvider show AuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart'
    as firebase_ui_auth_provider;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ttlines2/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:ttlines2/ui/themes.dart';
import 'package:ttlines2/ui/views/homepage_map.dart';
import 'package:ttlines2/ui/views/nz_map.dart';
import 'package:ttlines2/ui/views/regional_map.dart';
import 'package:ttlines2/ui/views/settings.dart';
import 'package:ttlines2/ui/views/taupo_view.dart';
import 'package:ttlines2/ui/views/tt.dart';
import 'package:ttlines2/ui/views/lake_omg.dart';
import 'package:ttlines2/ui/views/tt_webview.dart';
import 'package:ttlines2/ui/views/home.dart';
import 'package:ttlines2/ui/views/trout_data_log.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ttlines2/ui/views/update_app_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  await Future.delayed(const Duration(milliseconds: 500));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Turangi Tight Lines',
        theme: Themes.light,
        // app_version_number == current_app_version_number ? '/' : '/updateapp'
        // initialRoute: '/',
        initialRoute: '/updateapp',
        routes: <String, WidgetBuilder>{
          '/': (context) => const HomeView(),
          '/updateapp': (context) => const UpdataAppView(),
          '/nzmap': (context) => const NzMapView(),
          '/regionalmap': (context) => const RegionalMapView(),
          '/homepagemap': (context) => const HomePageMap(),
          '/taurangataupo': (context) => const TaurangaTaupoView(),
          '/tt_level': (context) => const TTWebview(),
          '/lakeO': (context) => const LakeOmgView(),
          '/laketaupo': (context) => const TaupoView(),
          '/fishinglog': (context) => const TroutDataView(),
          '/logsettings': (context) => const SettingsView(),
          '/sign-in': (context) {
            return firebase_ui_auth_provider.SignInScreen(
              providers: [firebase_ui_auth_provider.EmailAuthProvider()],
              actions: [
                firebase_ui_auth_provider.AuthStateChangeAction<
                    firebase_ui_auth_provider.SignedIn>((context, state) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/fishinglog', (route) => false);
                }),
                firebase_ui_auth_provider.EmailLinkSignInAction((context) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        const firebase_ui_auth_provider.EmailLinkSignInScreen(),
                  ));
                }),
                firebase_ui_auth_provider.ForgotPasswordAction(
                    (context, email) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        const firebase_ui_auth_provider.ForgotPasswordScreen(),
                  ));
                })
              ],
            );
          },
        });
  }
}
