import 'package:flutter/material.dart';
import 'package:flutterstudy/utils/ui_utils.dart';

class AnimationPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AnimationState();
  }
}

class _AnimationState extends State<AnimationPage>  with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    //创建动画周期为1秒的AnimationController对象
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    // 创建从50到200线性变化的Animation对象
    animation = Tween(begin: 5.0, end: 12.0).animate(controller)
      ..addListener(() {
        setState(() {}); //刷新界面
      });
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.repeat(reverse: true);
      }
    });
    controller.forward(); //启动动画
  }


  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Center(
              child: Container(
                  margin: EdgeInsets.only(bottom: animation.value*5- 13 * 5),
                  width: animation.value, // 将动画的值赋给widget的宽高
                  height: animation.value,
                  child: Image.asset("assets/images/icon_dayan.png")
              )),
        );
  }

  @override
  void dispose() {
    controller.dispose(); // 释放资源
    super.dispose();
  }
}