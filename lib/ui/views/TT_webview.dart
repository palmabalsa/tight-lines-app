import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TTWebview extends StatefulWidget {
  const TTWebview({Key? key}) : super(key: key);

  @override
  State<TTWebview> createState() => _TTWebviewState();
}

class _TTWebviewState extends State<TTWebview> {
  late final WebViewController ttController;
  var loadingPercentage = 0;
  String url =
      'https://www.waikatoregion.govt.nz/environment/envirohub/environmental-maps-and-data/station/42456/WL?dt=Level/';

  @override
  void initState() {
    super.initState();
    ttController = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            final host = Uri.parse(request.url).host;
            if (!host.contains(url)) {}
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(
        'https://www.waikatoregion.govt.nz/environment/envirohub/environmental-maps-and-data/station/42456/WL?dt=Level/',
      ))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      WebViewWidget(
        controller: ttController,
      ),
      if (loadingPercentage < 100)
        LinearProgressIndicator(
          value: loadingPercentage / 100.0,
        ),
    ]);
  }
}
