import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterstudy/widget/float_utils.dart';

class FlutterFloating extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FloatingState();
  }
}

class FloatingState extends State<FlutterFloating> {

  @override
  void initState() {
    _initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("悬浮窗测试"),
        leading: new IconButton(
            icon: Image.asset("assets/images/icon_title_back.png",
                width: 30, height: 30),
            onPressed: () {
              //导航到新路由
              Navigator.pop(context, "我是返回值");
            }),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new ElevatedButton(
                child: Text("显示悬浮船"),
                onPressed: () {
                  int platformViewId = -1;
                  FloatUtils.showFloat(platformViewId);
                  // _showOverlayWindow();
                }),
            new ElevatedButton(
                child: Text("隐藏悬浮船"),
                onPressed: () {
                  FloatUtils.hideFloat();
                })
          ],
        ),
      ),
    );
  }
}
