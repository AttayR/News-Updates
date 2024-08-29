
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch the current theme data
    final theme = Theme.of(context);

    return Scaffold(
     appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Privacy",
                style: TextStyle(
                  color: Colors.white, // White color for "World"
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              TextSpan(
                text: "Policy",
                style: TextStyle(
                  color: Colors.orange, // Orange color for "Pulse"
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 80, 2, 2),
        iconTheme: IconThemeData(
          color:
              Colors.white, // This will change the color of the icons to white
        ),
      ),
      body: WebView(
        initialUrl: 'https://codeteck.com/world-pulse/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}

