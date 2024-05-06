// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowTemple360View extends StatefulWidget {
  final String url;
  const ShowTemple360View({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<ShowTemple360View> createState() => _ShowTemple360ViewState();
}

class _ShowTemple360ViewState extends State<ShowTemple360View> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: controller,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.reload(),
        child: const Icon(
          Icons.refresh_outlined,
          size: 35,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _ShowTemple360ViewState();
  }
}
