import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PageDetail extends StatefulWidget {
  const PageDetail({Key? key}) : super(key: key);

  @override
  State<PageDetail> createState() => _PageDetailState();
}

class _PageDetailState extends State<PageDetail> {
  int position = 1;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as List;

    final String url = args[0];
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("${args[1]}"),
        ),
        body: IndexedStack(index: position, children: <Widget>[
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Deskripsi: ${args[2]}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Divider(color: Colors.blue,),
              Expanded(
                child: WebView(
                  initialUrl: url,
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageStarted: (value) {
                    setState(() {
                      position = 1;
                    });
                  },
                  onPageFinished: (value) {
                    setState(() {
                      position = 0;
                    });
                  },
                ),
              ),
            ],
          ),
          const Center(child: CircularProgressIndicator()),
        ]));
  }
}
