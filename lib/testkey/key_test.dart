import 'dart:math';

import 'package:flutter/material.dart';

/// 现象
/// 1、没有key的 StatefulWidget 删除异常
/// 2、StatelessWidget 删除正常
/// 3、添加key的 StatefulWidget 删除正常
/// 4、将 randomcolor 迁移到 StatefulWidget 中也正常
///
/// 现象解释：https://www.6hu.cc/archives/77982.html
///
class KeyDemo extends StatefulWidget {
  const KeyDemo({Key? key}) : super(key: key);

  @override
  _KeyDemoState createState() => _KeyDemoState();
}

class _KeyDemoState extends State<KeyDemo> {
  /// 没有key的 StatefulWidget 删除异常
  List<WidgetItem> items = [
    WidgetItem("第一个"),
    WidgetItem("第二个"),
    WidgetItem("第三个"),
  ];

  /// StatelessWidget 删除正常
  // List<WidgetLessItem> items = [
  //   WidgetLessItem("第一个"),
  //   WidgetLessItem("第二个"),
  //   WidgetLessItem("第三个"),
  // ];

  /// 添加key的 StatefulWidget 删除正常
  // List<WidgetItem> items = [
  //   WidgetItem("第一个", key: ValueKey(1)),
  //   WidgetItem("第二个", key: ValueKey(2)),
  //   WidgetItem("第三个", key: ValueKey(3)),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("key测试"),),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: items,
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              items.removeAt(0);
            });
          }),
    );
  }
}

class WidgetItem extends StatefulWidget {
  String text = "";

  WidgetItem(this.text, {Key? key}) : super(key: key);

  @override
  _WidgetItemState createState() => _WidgetItemState();
}

class _WidgetItemState extends State<WidgetItem> {
  final randomcolor = Color.fromRGBO(
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
      1
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: randomcolor,
      child: Text(widget.text),
    );
  }
}

class WidgetLessItem extends StatelessWidget {
  String text = "";

  WidgetLessItem(this.text);

  final randomcolor = Color.fromRGBO(
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
      1
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: randomcolor,
      child: Text(this.text),
    );
  }
}

