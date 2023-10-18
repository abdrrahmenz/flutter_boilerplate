import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/core.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({
    Key? key,
    this.appBar,
    required this.url,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.onUpdateVisitedUri,
    this.onWebViewCreated,
  }) : super(key: key);

  final PreferredSizeWidget? appBar;
  final String url;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final NavigationDelegate? onUpdateVisitedUri;
  final Function(WebViewController)? onWebViewCreated;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButton: widget.floatingActionButton,
      body: Stack(
        children: [
          _buildWebView(),
          _buildIndicator(),
        ],
      ),
    );
  }

  Widget _buildWebView() {
    return WebView(
      initialUrl: widget.url,
      onProgress: (int progress) {
        log('WEBVIEW PROGRESS: $progress', name: 'WEBVIEW');
        setState(() {
          this.progress = progress / 100;
        });
      },
      navigationDelegate: widget.onUpdateVisitedUri,
      javascriptMode: JavascriptMode.unrestricted,
      onWebResourceError: (error) {
        log(
          'FAILURE LOAD: ${error.failingUrl} => ${error.description}',
          name: 'WEBVIEW',
        );
      },
      onWebViewCreated: widget.onWebViewCreated,
      gestureNavigationEnabled: true,
    );
  }

  Widget _buildIndicator() {
    return progress < 1
        ? SizedBox(
            height: 3,
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: context.theme.disabledColor.withOpacity(.3),
            ),
          )
        : const SizedBox();
  }
}
