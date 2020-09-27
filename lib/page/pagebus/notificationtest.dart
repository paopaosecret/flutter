import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstudy/utils/ui_utils.dart';

///总结：Notification 主要用来子Widget共享状态给父Widget
///InheritedWidget 的数据流动方式是从父 Widget 到子 Widget 逐层传递，
///那 Notificaiton 则恰恰相反，数据流动方式是从子 Widget 向上传递至父 Widget。
///这样的数据传递机制适用于子 Widget 状态变更，发送通知上报的场景。

///1、自定义一个Notification
class CustomNotification extends Notification {
  CustomNotification(this.msg);

  final String msg;
}

///2、抽离出一个子Widget用来发送通知
class CustomChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      onPressed: () {
        CustomNotification(DateTime.now().toIso8601String()).dispatch(context);
      },
      child: Text("发送一个自定义通知"),
    );
  }
}

///3、在子Widget的父Widget中，监听通知
class CustomPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CustomPageWidget();
  }
}

class _CustomPageWidget extends State<CustomPage> {
  String _msg = "默认";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return NotificationListener<CustomNotification>(
        onNotification: (nofitication) {
          setState(() {
            _msg = nofitication.msg;
          });
          return true;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_msg),
            Container(
                width: UITools.getScreenWidth(context),
                height: 80,
                child: CustomChild()
            ) ///将子Widget加入到视图树中
          ],
        ));
  }
}
