import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleScreen extends StatefulWidget {
  String blogUrl;
  ArticleScreen({super.key, required this.blogUrl});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('News',
            style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
          centerTitle: true,
          elevation: 0.0,),
        body: Container(
        child: WebView(
            initialUrl: widget.blogUrl,
            javascriptMode: JavascriptMode.unrestricted,
        ),
      )
    );
  }
}
