import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class UITools {
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

///设置相对于子Widget的padding 属性，
Widget padAll(Widget widget, var value){
  return new Padding(padding: EdgeInsets.all(value), child: widget);
}

Widget pad(Widget widget, {double? l,double?  t,double?  r,double? b}){
  return new Padding(padding: EdgeInsets.fromLTRB(l ??= 0.0, t ??= 0.0, r ??= 0.0, b ??= 0.0), child: widget);
}

///设置控件是否显示
Widget visible(Widget widget, bool flag){
  return Visibility(
      visible:  flag,
      child: widget,
  );
}

///显示对话框
void showCustomDialog(
    BuildContext context,         ///上下文环境
    String titleText,             ///title 文本
    String contentText,           ///内容文本
    String leftButton,            ///底部左边按钮文本
    String rightButton,           ///底部右边按钮文本
    VoidCallback? leftListener,        ///底部左边按钮事件
    VoidCallback? rightListener) {     ///底部右边按钮事件
  var title = Row(//标题
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      new Text(titleText,style: TextStyle(fontSize: 18),)],
  );
  var content = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      pad(Text(contentText,style: TextStyle(fontSize: 16),),t:5)
    ]
  );
  var dialog = CupertinoAlertDialog(
    content: content,
    title: title,
    actions: <Widget>[
      CupertinoButton( child: Text(leftButton),
        onPressed: leftListener,
      ),
      CupertinoButton( child: Text(rightButton),
        onPressed: rightListener,
      ),
    ],
  );
  showDialog(context: context, builder: (context) => dialog);
}
