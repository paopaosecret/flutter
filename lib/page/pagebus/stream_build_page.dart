import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StreamBuilderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _State();
  }
}

class _State extends State<StreamBuilderPage> {

  int offset = 0;
  final StreamController<int> _controller = StreamController<int>();

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("StramBuildPage"),),
      body: Center(
        child: StreamBuilder<int>(
          stream: _controller.stream,
          initialData: offset,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot){
            return Text("数字被改为：${snapshot.data}");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          offset = new Random().nextInt(10000);
          _controller.sink.add(offset);
        },
      ),
    );
  }
}