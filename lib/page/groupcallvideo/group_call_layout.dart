import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterstudy/page/groupcallvideo/anim_switch_layout_demo_page.dart';
import 'package:flutterstudy/widget/toast.dart';

///通过 CustomMultiChildLayout 自定义控件
class GroupCallLayout extends StatefulWidget {
  @override
  _GroupCallLayoutState createState() =>
      _GroupCallLayoutState();
}

class _GroupCallLayoutState extends State<GroupCallLayout> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  ///用于 LayoutId 指定
  ///CircleLayoutDelegate 操作具体 Child 的 ChildId 是通过 LayoutId 指定的
  List customLayoutId = ["0", "1"].toList();
  // List customLayoutId = ["0", "1", "2"].toList();
  // List customLayoutId = ["0", "1", "2", "3"].toList();
  // List customLayoutId = ["0", "1", "2", "3", "4"].toList();
  // List customLayoutId = ["0", "1", "2", "3", "4", "5", "6", "7", "8"].toList();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    double childSize = 66;
    return Column(
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: MyPainter(_animation.value),
              child: child,
            );
          },
          child: new Container(
            color: Colors.white,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).width,
            ///使用 CustomMultiChildLayout
            child: CustomMultiChildLayout(
              ///使用 CircleLayoutDelegate 实现 child 的布局
              delegate: GroupLayoutDelegate(customLayoutId as List<String>,
                  ///中心点位置
                  center: Offset(MediaQuery.sizeOf(context).width / 2,
                      MediaQuery.sizeOf(context).width / 2)),
              children: <Widget>[
                ///使用 LayoutId 指定 childId
                for (var item in customLayoutId)
                  new LayoutId(id: item, child: ContentItem(item, childSize)),
              ],
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.amberAccent,
          ),
          onPressed: () {
            if (customLayoutId.length < 9) {
              setState(() {
                customLayoutId.add("${customLayoutId.length}");
              });
            }
          },
          child: new Text(
            "加",
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.indigoAccent),
          onPressed: () {
            setState(() {
              if (customLayoutId.length > 1) {
                customLayoutId.removeLast();
              }
            });
          },
          child: new Text(
            "减",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

///自定义实现群组通话布局
class GroupLayoutDelegate extends MultiChildLayoutDelegate {
  final List<String> customLayoutId;

  final Offset center;

  late double screenWidth;

  final Size childSize = Size(77, 77);

  GroupLayoutDelegate(this.customLayoutId,
      {this.center = Offset.zero});

  @override
  void performLayout(Size size) {
    /// 这里拿到的 size 是 当前 Delegate 代理的 Layout Widget的宽高，也就是管理子widget的父布局的宽高
    print("GroupLayoutDelegate performLayout start size:${size.toString()}");
    screenWidth = size.width;
    if (customLayoutId.length == 3) {
      _performLayout21(size);
    } else if (customLayoutId.length < 5) {
      _performLayout22(size);
    } else {
      _performLayout33(size);
    }
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) => false;

  void _performLayout22(Size size){
    for (var item in customLayoutId) {
      if (hasChild(item)) {
        int index = int.parse(item);
        Size childSize = Size(screenWidth/2, screenWidth/2);

        ///设置 child 大小
        layoutChild(item, BoxConstraints.loose(childSize!));
        double offsetX = index % 2 == 0 ? 0 : screenWidth/2;
        double offsetY = index < 2 ? 0 : screenWidth/2;
        var result = new Offset(offsetX, offsetY);
        print("LayoutId = $item :{size:${size.toString()}, offset: ${result.toString()}");
        ///设置 child 位置
        positionChild(item, result);
      }
    }
  }

  void _performLayout21(Size size){
    for (var item in customLayoutId) {
      if (hasChild(item)) {
        int index = int.parse(item);
        Size childSize = Size(screenWidth/2, screenWidth/2);

        ///设置 child 大小
        layoutChild(item, BoxConstraints.loose(childSize!));
        double offsetX = 0;
        double offsetY = 0;
        if (index == 1) {
          offsetX = screenWidth/2;
        } else if (index == 2) {
          offsetX = screenWidth/4;
          offsetY = screenWidth/2;
        }
        var result = new Offset(offsetX, offsetY);
        print("LayoutId = $item :{size:${size.toString()}, offset: ${result.toString()}");
        ///设置 child 位置
        positionChild(item, result);
      }
    }
  }

  void _performLayout33(Size size){
    for (var item in customLayoutId) {
      if (hasChild(item)) {
        int index = int.parse(item);
        Size childSize = Size(screenWidth/3, screenWidth/3);

        ///设置 child 大小
        layoutChild(item, BoxConstraints.loose(childSize!));
        double offsetX = 0;
        double offsetY = 0;
        if (index % 3 == 0) {
          offsetX = 0;
        } else if (index % 3 == 1) {
          offsetX = screenWidth/3;
        } else {
          offsetX = screenWidth*2/3;
        }
        if (index < 3) {
          offsetY = 0;
        }else if (index < 6) {
          offsetY = screenWidth/3;
        } else {
          offsetY = screenWidth*2/3;
        }
        var result = new Offset(offsetX, offsetY);
        print("LayoutId = $item :{size:${size.toString()}, offset: ${result.toString()}");
        ///设置 child 位置
        positionChild(item, result);
      }
    }
  }
}

///child
class ContentItem extends StatelessWidget {
  final String text;

  final double childSize;

  ContentItem(this.text, this.childSize);

  Color getRandomColor() {
    final Random _random = Random();
    return Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        ToastUtils.showToast("点击了$text");
      },
      child: Container(
        color: getRandomColor(),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double progress;

  MyPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    // 在这里添加你的动画绘制逻辑
    // 例如，你可以根据 `progress` 的值来改变子widget的位置
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

