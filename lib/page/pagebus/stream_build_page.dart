import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
///总结：StreamBuilder 主要用来在兄弟Widget之间通信
///Notification 主要用来子Widget共享状态给父Widget
///InheritedWidget 的数据流动方式是从父 Widget 到子 Widget 逐层传递，

class StreamBuilderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<StreamBuilderPage> {

  int streamData = 0;
  // TODO 第一步：构造数据的控制器，用于往流中添加数据(示例为int类型数据)
  final StreamController<int> _controller = StreamController<int>();

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("StramBuildPage"),),
      body: Center(
        //TODO 第二步：监听data的变化
        child: StreamBuilder<int>(
          // 数据流：用于监听的数据流
          stream: _controller.stream,
          //初始显示的值，如果不设置 第一帧将会不显示
          initialData: streamData,
          //syncWidgetBuilder<T>builder：结合流元素与Widget的方法参数。builder的入参是用于构建Widget的上下文BuildContext和异步数据AsyncSnapshot。返回值就是使用者想要根据流元素显示的Widget。
          builder: (BuildContext context, AsyncSnapshot<int> snapshot){
            if (snapshot.hasError) { // 计算出错的widget
              return Text("error：${snapshot.error}");
            }
            if (snapshot.hasData) {   //有数据的widget
              return Text("数字被改为：${snapshot.data}");
            }
            return Text("数字被改为：0"); //兜底widget
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          streamData = new Random().nextInt(10000);
          // TODO 第三步：流中添加元素
          _controller.add(streamData);
        },
      ),
    );
  }
}