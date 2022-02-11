import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Javascript Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Javascript Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebView(
        onWebViewCreated: (WebViewController webViewController) async {
          _controller = webViewController; // 生成されたWebViewController情報を取得する
        },
        initialUrl: 'https://mymyser.com/flutterjs.html',
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: {
          JavascriptChannel(
            name: 'flutterJavaScript',
            onMessageReceived: (result) async {
              print(result.message);
            },
          )
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _executeJavascript,
      ),

    );
  }

  Future<void> _executeJavascript() async {
    String result = await _controller.runJavascriptReturningResult('executeJavascript()');
    print(result);
  }
}
