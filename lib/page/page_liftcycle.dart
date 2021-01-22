import 'package:flutter/material.dart';
import 'package:flutterstudy/utils/ui_utils.dart';
import 'package:flutterstudy/widget/title_bar.dart';

///测试生命周期
class LiftCyclePage extends StatefulWidget{

  LiftCyclePage(){
    print("构造函数执行");
  }

  @override
  State<StatefulWidget> createState() {

    return _LifeCycleState();
  }
}

class _LifeCycleState extends State<LiftCyclePage>{
  int count = 0;

  @override
  void initState() {
    print("初始化 initState");
    super.initState();
  }

  @override
  void didUpdateWidget(LiftCyclePage oldWidget) {
    print('组件更新 didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void reassemble() {
    super.reassemble();
    print('重新安装 reassemble');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('停用  deactivate');
  }

  @override
  void dispose() {
    super.dispose();
    print('销毁 dispose');
  }

  @override
  void didChangeDependencies() {
    print("依赖改变 didChangeDependencies");
    super.didChangeDependencies();
  }

  @override
  void setState(fn) {
    print('状态刷新 setState');
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: TitleBar().titleBar(context, '测试生命周期',),
      body: Container(
        height: UITools.getScreenHeight(context),
        width: UITools.getScreenWidth(context),
        color: Color(0xFF00FF00),
        child: new Center(
          child: new ElevatedButton(
            onPressed: () => setState(() => count++),
            child: new Text('$count'),
          ),
        ),
      ),
    );
  }

}