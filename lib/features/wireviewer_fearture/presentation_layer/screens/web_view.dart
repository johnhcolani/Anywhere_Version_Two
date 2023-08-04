import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/resources/color_manager.dart';
import '../../data_layer/models/wireviewer_model.dart';

class WebViewAppStack extends StatefulWidget {
  final WireViewerCharacter character;

  final String characterName;

  const WebViewAppStack(
      {Key? key, required this.characterName, required this.character})
      : super(key: key);

  @override
  State<WebViewAppStack> createState() => _WebViewAppStackState();
}

class _WebViewAppStackState extends State<WebViewAppStack> {
  var loadingPercentage = 0;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(
        Uri.parse(widget.character.firstUrl),
      );
  }

  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: ColorManager.darkBlue,
        height: he*0.05,
      ) ,
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: ColorManager.darkBlue,
        title: Center(
            child: Text(
          widget.characterName ?? "",
          style: TextStyle(color: ColorManager.white),
        )),
      ),
      body: Stack(children: [
        WebViewWidget(
          controller: controller,
        ),
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            minHeight: 10,
            color: ColorManager.orange,
            value: loadingPercentage / 100.0,
          ),
      ]),
    );
  }
}
