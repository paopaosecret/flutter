import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TitleBar {

  ///包含含 左侧返回按钮 及中间标题 右边文本按钮
  ///使用1：appBar: TitleBar().titleBar(context, '意见反馈',),      //显示返回按钮和  中间文本
  ///使用2：  appBar: TitleBar().titleBar(context, '意见反馈',rightText: "提交", onRightPressed:(){}), //显示返回按钮和  中间文本   右边文本按钮
  titleBar(BuildContext context, String title, {VoidCallback? onBackPressed,
    String? rightText, VoidCallback? onRightPressed}) {
    ///使用PreferredSize包裹可以控制AppBar高度
    return PreferredSize(
      preferredSize: Size(double.infinity, 48),
      child: AppBar(
        elevation: 0,
        title: _title(title),
        centerTitle: true,
        leading: new IconButton(
          icon:  Image.asset("assets/images/icon_title_back.png",width:30,height:30),
          onPressed: onBackPressed ?? (){
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xFFFFFFFF),
        actions: <Widget>[
          Visibility(
            visible: rightText != null ? true : false,
            child: new IconButton(
              icon: Text(rightText ?? "",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 16,
                  )
              ),
              onPressed: onRightPressed ?? (){

              },
            ),
          ),
        ], systemOverlayStyle: SystemUiOverlayStyle.dark,
//
      ),
    );
  }

  ///设置中间文本
  Widget _title(String title){
    return Text(title ?? "",
      style: TextStyle(
          color: Colors.black87,
          fontSize: 20
      ),
    );
  }
}