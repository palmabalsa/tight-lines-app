import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TTWebview extends StatefulWidget {
  TTWebview({Key? key}) : super(key: key);

  @override
  State<TTWebview> createState() => _TTWebviewState();
}

class _TTWebviewState extends State<TTWebview> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl:
          'https://waikatoregion.govt.nz/environment/envirohub/environmental-maps-and-data/station/42456/WL?dt=Level',
      javascriptMode: JavascriptMode.unrestricted,
      navigationDelegate: (NavigationRequest request) {
        return NavigationDecision.prevent;
      },
    );
  }
}
