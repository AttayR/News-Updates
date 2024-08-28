import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
String blogUrl;
ArticleView({required this.blogUrl});
  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending News"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: WebView(
          initialUrl:  widget.blogUrl, 
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}