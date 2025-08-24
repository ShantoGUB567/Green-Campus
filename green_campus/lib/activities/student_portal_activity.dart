import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StudentPortalActivity extends StatefulWidget {
  const StudentPortalActivity({super.key});

  @override
  State<StudentPortalActivity> createState() => _StudentPortalActivityState();
}

class _StudentPortalActivityState extends State<StudentPortalActivity> {
  late WebViewController _webViewController;
  bool _isLoading = true;
  String _currentUrl = 'https://studentportal.green.edu.bd/Account/Login';

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
              _currentUrl = url;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            // Allow all navigation
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(_currentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Portal'),
        backgroundColor: const Color(0xFF197E46),
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _webViewController.reload();
            },
            tooltip: 'Refresh',
          ),
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              _webViewController.loadRequest(Uri.parse('https://studentportal.green.edu.bd/Account/Login'));
            },
            tooltip: 'Go to Home',
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _webViewController),
          if (_isLoading)
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF197E46)),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Loading Student Portal...',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF197E46),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                _currentUrl,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF197E46)),
              onPressed: () async {
                if (await _webViewController.canGoBack()) {
                  _webViewController.goBack();
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward, color: Color(0xFF197E46)),
              onPressed: () async {
                if (await _webViewController.canGoForward()) {
                  _webViewController.goForward();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
