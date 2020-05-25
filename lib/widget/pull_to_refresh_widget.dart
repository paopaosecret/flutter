import 'package:flutter/material.dart';
import 'package:flutterstudy/widget/pull_to_refresh_header_widget.dart';

/// 刷新状态枚举
enum _RefreshStatus{
  ///初始化状态
  INIT,

  ///下拉可以刷新
  PULL_TO_REFRESH,

  ///刷新中
  REFRESHING,

  ///下拉刷新释放
  RELEASE_TO_REFRESH,
}

///创建下拉头部视图函数
typedef HeaderBuilder = RefreshHeaderWidget Function(BuildContext context);
///