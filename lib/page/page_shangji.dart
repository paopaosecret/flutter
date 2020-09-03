import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterstudy/redux/action/shangjia_action.dart';
import 'package:flutterstudy/redux/state/app_state.dart';
import 'package:flutterstudy/widget/title_bar.dart';
import 'package:flutterstudy/widget/toast.dart';

class ShangJiPage extends StatefulWidget {
  String str;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ShangJiState();
  }
}

class _ShangJiState extends State<ShangJiPage> {

  @override
  Widget build(BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(ShangJiAction(10));  //第一步：发送一个时间到Redux
    return StoreConnector<AppState, ShangJiPageState>(
      distinct: true,
      converter: (store) => store.state.shangJiPageState,
      builder: (BuildContext context, ShangJiPageState shangJiPageState) {
        return Scaffold(
            appBar: TitleBar().titleBar(context, '商机中心',
              rightText: "提交",
              onRightPressed: (){
                int a = Random().nextInt(100);
                ToastUtils.showToast("a = ${a}");
                StoreProvider.of<AppState>(context).dispatch(ShangJiAction(a));  //第一步：发送一个时间到Redux
              }
            ),
            body:Container(
              color: Colors.white,
              child: Center(
                child: GestureDetector(
                  onTap: (){
                    int a = Random().nextInt(100);
                    ToastUtils.showToast("a = ${a}");
                    StoreProvider.of<AppState>(context).dispatch(ShangJiAction(a));  //第一步：发送一个时间到Redux
                  },
                  child: Text(
                    shangJiPageState.data.toString(),
                    style: Theme.of(context).textTheme.display1,
                  ),
                ),
              ),
            )
          );
      },
    );
  }
}