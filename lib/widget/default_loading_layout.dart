import 'package:flutter/material.dart';
import 'dart:math' as Math;

import 'package:flutterstudy/widget/refresh_header_widget.dart';

class DefaultRefreshHeaderWidget<_DefaultIndicatorState>
    extends RefreshHeaderWidget {
  DefaultRefreshHeaderWidget({Key? key}) : super(key: key);

  @override
  _DefaultLoadingState createState() {
    return new _DefaultLoadingState();
  }
}

const int _reset = 0;
const int _releaseToRefresh = 1;
const int _pullToRefresh = 2;
const int _refreshing = 3;

class _DefaultLoadingState extends RefreshState<DefaultRefreshHeaderWidget> {
  int mode = 0;
  late int lastUpdateTime;
  TextStyle style = TextStyle(fontSize: 12);
  TextStyle stateStyle = TextStyle(fontSize: 13);

  @override
  void initState() {
    super.initState();
    lastUpdateTime = DateTime.now().millisecondsSinceEpoch;
  }

  @override
  void reset() {
    setState(() {
      mode = _reset;
    });
  }

  @override
  void onMoving(double offset, double totalHeight, double maxDragHeight) {
    if (offset > maxDragHeight) {
      if (mode != _releaseToRefresh) {
        setState(() {
          mode = _releaseToRefresh;
        });
      }
    } else {
      if (mode != _pullToRefresh) {
        setState(() {
          mode = _pullToRefresh;
        });
      }
    }
  }

  @override
  void refreshing() {
    setState(() {
      mode = _refreshing;
      lastUpdateTime = DateTime.now().millisecondsSinceEpoch;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget textWidget = _buildText();
    Widget textLastUpdateWidget = _buildLastUpdateText();
    Widget iconWidget = _buildIcon();

    List<Widget> children = <Widget>[
      iconWidget,
      new Container(width: 15.0, height: 15.0),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          textWidget,
          Container(width: 15.0, height: 1.0),
          textLastUpdateWidget
        ],
      ),
    ];

    return new Container(
      alignment: Alignment.center,
      height: 60.0,
      child: new Center(
        child: new Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }

  Widget _buildText() {
    switch (mode) {
      case _releaseToRefresh:
        return new Text(
          "释放立即刷新",
          style: stateStyle,
        );
      case _refreshing:
        return new Text("刷新中", style: stateStyle);
      default:
        return new Text("下拉刷新", style: stateStyle);
    }
  }

  Widget _buildLastUpdateText() {
    return new Text("上次更新时间: " + friendlyTime(), style: style);
  }

  Widget _buildIcon() {
    switch (mode) {
      case _releaseToRefresh:
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationX(Math.pi), // 这里是弧度,180角度的弧度是3.14
          child: Image.asset(
            "assets/images/icon_pulltorefresh_arrow.png",
            width: 16,
            height: 23,
          ),
        );
//      case _refreshing:
//        return new CircularProgressIndicator(strokeWidth: 1.0);
      case _refreshing:
        return new Container();
      default:
        return Image.asset(
          "assets/images/icon_pulltorefresh_arrow.png",
          width: 16,
          height: 23,
        );
    }
  }

  String friendlyTime() {
    //获取time距离当前的秒数
    int ct = ((DateTime.now().millisecondsSinceEpoch - lastUpdateTime) ~/ 1000)
        .toInt();

    if (ct == 0) {
      return "刚刚";
    }

    if (ct > 0 && ct < 60) {
      return "$ct 秒前";
    }

    if (ct >= 60 && ct < 3600) {
      int max = Math.max(ct ~/ 60, 1);
      return "$max 分钟前";
    }
    if (ct >= 3600 && ct < 86400) {
      int d = ct ~/ 3600;
      return "$d 小时前";
    }

    if (ct >= 86400 && ct < 2592000) {
      //86400 * 30
      int day = ct ~/ 86400;
      return "$day 天前";
    }
    if (ct >= 2592000 && ct < 31104000) {
      //86400 * 30
      int month = ct ~/ 2592000;
      return "$month 月前";
    }
    int year = ct ~/ 31104000;
    return "$year 年前";
  }
}
