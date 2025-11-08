import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  InAppWebViewController? webViewController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    developer.log(
      '🌐 WebViewScreen initialized with URL: ${widget.url}',
      name: 'WebViewScreen',
    );

    if (widget.url.isEmpty) {
      developer.log('❌ Empty URL provided to WebView', name: 'WebViewScreen');
    } else {
      try {
        final uri = Uri.parse(widget.url);
        developer.log(
          '✅ URL parsed successfully: scheme=${uri.scheme}, host=${uri.host}',
          name: 'WebViewScreen',
        );
      } catch (error, stackTrace) {
        developer.log(
          '❌ Invalid URL format: $error',
          name: 'WebViewScreen',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(widget.url)),
              initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true,
                allowsInlineMediaPlayback: true,
                mediaPlaybackRequiresUserGesture: false,
                userAgent:
                    'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1',
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                webViewController = controller;
              },
              onLoadStart: (InAppWebViewController controller, WebUri? url) {
                developer.log(
                  '📄 WebView page started loading: $url',
                  name: 'WebViewScreen',
                );
                setState(() {
                  _isLoading = true;
                });
              },
              onLoadStop: (InAppWebViewController controller, WebUri? url) {
                developer.log(
                  '✅ WebView page finished loading: $url',
                  name: 'WebViewScreen',
                );
                setState(() {
                  _isLoading = false;
                });
              },
              onReceivedError:
                  (
                    InAppWebViewController controller,
                    WebResourceRequest request,
                    WebResourceError error,
                  ) {
                    developer.log(
                      '❌ WebView error: ${error.description} (Code: ${error.type})',
                      name: 'WebViewScreen',
                    );
                  },
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
