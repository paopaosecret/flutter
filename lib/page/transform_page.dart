import 'package:flutter/material.dart';
import 'package:flutterstudy/utils/ui_utils.dart';
import 'package:flutterstudy/widget/title_bar.dart';
import 'dart:math';

class TransformPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TransformPageState();
  }
}

class _TransformPageState extends State<TransformPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: TitleBar().titleBar(
        context,
        'Transform',
      ),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("缩放测试:Transform中的child大小为Transform父widget大小的缩放尺寸"),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 100,
                  width: UITools.getScreenWidth(context),
                  color: Color(0xFFFFFF00),
                  child: Transform.scale(
                    scale: 0.5, //子widget相对于Transform的父widget的缩放比例，子Widget设置宽高无效
                    origin: Offset(0, 0), //缩放原点，
                    alignment: Alignment.topLeft, //缩放对齐方式，对齐方式是以缩放原点为准的
                    child: Container(
                      color: Color(0x990000FF),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("平移测试:Transform中的child位置为Transform父widget位移的偏移量"),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 100,
                  width: UITools.getScreenWidth(context) - 100,
                  color: Color(0xFFFFFF00),
                  child: Transform.translate(
                    offset: Offset(50, 50),
                    child: Container(
                      color: Color(0x990000FF),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text("旋转测试:Transform中的child位置为Transform父widget位移的偏移量"),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50,
                  width: 100,
                  color: Color(0xFFFFFF00),
                  child: Transform.rotate(
                    alignment: Alignment.topLeft, //其实用于确定旋转中心
                    angle: pi / 4, //旋转角度和方向，顺时针为正角度，逆时针为负角度
                    child: Container(
                      color: Color(0x990000FF),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text("旋转Matrix4 方式:Matrix4.rotationZ只可进行单轴旋转;Matrix4.identity()..rotateZ可以多个轴叠加"),
                SizedBox(
                  height: 15,
                ),
                Container(
                    height: 100,
                    width: 200,
                    color: Color(0xFFFFFF00),
                    child: Stack(
                      children: <Widget>[
                        Transform(
                          transform: Matrix4.identity()..rotateX(pi/4),
                          alignment: Alignment.center,
                          child: Container(
                            color: Color(0x6600FFFF),
                            child: Center(child: Text("旋转x")),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.identity()..rotateY(pi/4),
                          alignment: Alignment.center,
                          child: Container(
                            color: Color(0x66FF00FF),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.identity()..rotateZ(pi/2),
                          alignment: Alignment.center,
                          child: Container(
                            color: Color(0x669900FF),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.identity()..rotateZ(pi/2)..rotateY(pi/4)..rotateX(pi/4),
                          alignment: Alignment.center,
                          child: Container(
                            color: Color(0x660000FF),
                          ),
                        ),
                      ],
                    )),



                SizedBox(
                  height: 100,
                ),
              ],
            );
          }),
    );
  }
}
