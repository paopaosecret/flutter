import 'package:flutter/material.dart';
import 'package:flutterstudy/utils/ui_utils.dart';

class AnimationPage extends StatefulWidget {
  String str;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AnimationState();
  }
}

class _AnimationState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    //创建动画周期为1秒的AnimationController对象
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    // 创建从50到200线性变化的Animation对象
    animation = Tween(begin: 20.0, end: 30.0).animate(controller)
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
    return Container(
        width: UITools.getScreenWidth(context),
        height: 430,
        //设置背景图片
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/icon_game_scene.png"),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 60.0),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: (animation.value - 20) * 2),
                child: Image.asset("assets/images/icon_dayan.png", height: 7),
              ),
              Container(
                margin: EdgeInsets.only(
                    bottom: (animation.value - 20) * 4.5 + 5,
                    left: (animation.value - 20) * 1),
                child: Image.asset("assets/images/icon_dayan.png", height: 10),
              )
            ],
          ),
        ));
  }

  @override
  void dispose() {
    controller.dispose(); // 释放资源
    super.dispose();
  }
}
