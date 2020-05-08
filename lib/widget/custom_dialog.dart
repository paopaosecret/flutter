import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///显示对话框
class CustomDialog{
  static void showCustomDialog(
      BuildContext context,         ///上下文环境
      String titleText,             ///title 文本
      String contentText,           ///内容文本
      String leftButton,            ///底部左边按钮文本
      String rightButton,           ///底部右边按钮文本
      Function leftListener,        ///底部左边按钮事件
      Function rightListener) {     ///底部右边按钮事件

    ///标题，对话框标题
    var title = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Visibility(
            visible: titleText.isNotEmpty,
            child: new Text(titleText,style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),),)
        ),
      ],
    );

    ///对话框提示内容
    var content = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(contentText,style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 14,
            ),),
          )
        ]
    );

    ///对话框对象
    var dialog = CupertinoAlertDialog(
      content: content,
      title: title,
      actions: <Widget>[
        CupertinoButton(
          child: Text(
            leftButton,
            style: TextStyle(
                fontSize: 18,
                color: Color(0xFF030303),
                fontWeight: FontWeight.w600,
              ),
            ),
          onPressed: leftListener ?? (){
            Navigator.pop(context);
          },
        ),

        CupertinoButton(
          child: Text(
            rightButton,
            style: TextStyle(
              color: Color(0xFFFF552E),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: rightListener ?? (){
            Navigator.pop(context);
          },
        ),
      ],
    );
    showDialog(context: context, builder: (context) => dialog);
  }
}

