import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstudy/utils/ui_utils.dart';

///总结：InheritedWidget 主要用来子Widget共享父Widget的数据

///part 1 使用InheritedWidget将数据传递给子Widget
///InheritedWidget:将数据可以传递给子widget
class CountContainer extends InheritedWidget {
  ///1、子树中的组件通过CountContainer.of(context)访问共享状态。
  ///注：1.12.1之前的写法，之后被废弃
//  static CountContainer of(BuildContext context) => context.inheritFromWidgetOfExactType(CountContainer) as CountContainer;
  ///注：1.12.1之后的写法子树中的组件通过CountContainer.of(context)访问共享状态。
  static CountContainer? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CountContainer>();

  ///2、定义共享的数据
  final int count;

  ///3、创建构造方法,  ****注意构造方法初始化调用父类的构造方法 super****
  CountContainer(this.count, {Key? key, required Widget child})
      : super(key: key, child: child);

  ///4、会在Flutter判断InheritedWidget是否需要重建，从而通知下层观察者组件更新数据时被调用到。
  ///在这里，我们直接判断 count 是否相等即可。
  @override
  bool updateShouldNotify(CountContainer oldWidget) {
    return count != oldWidget.count;
  }
}

class CounterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CountPageState();
  }
}

class _CountPageState extends State<CounterPage> {
  ///顶级Widget的数据
  int count = 10;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///通过InheritedWidget(CountContainer)将当前Widget的数据(count)共享给子Widget(Countet)
    return Material(
      child: CountContainer(
        count,
        child: Column(
          children: <Widget>[
            GestureDetector(
                onTap:(){
                  setState(() {
                    this.count = Random(100).nextInt(500);
                  });

                },
                child: Container(
                    width: UITools.getScreenWidth(context),
                    height: 100,
                    child: Text("改变Count"))),
            Container(
                width: UITools.getScreenWidth(context),
                height: 300,
                child: new Counter()),
          ],
        ),
      ),
    );
  }
}

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///获取InheritedWidget节点
    CountContainer? state = CountContainer.of(context);

    return Scaffold(
      appBar: AppBar(title: Text("InheritedWidget demo")),
      body: Text(
        'You have pushed the button this many times: ${state?.count}',
      ),
    );
  }
}

///part 2：InheritedWidget 仅提供了数据读的能力，如果我们想要修改它的数据，则需要把它和 StatefulWidget 中的 State 配套使用。
class Count2Container extends InheritedWidget {
  static Count2Container? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Count2Container>();

  ///通过StatefulWidget中的state，修改其存储的数据
  final _Counter2PageState state;

  final Function increment;

  ///创建构造器
  Count2Container(
      {Key? key,
      required this.state,
      required this.increment,
      required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(Count2Container oldWidget) {
    return state.count != oldWidget.state.count;
  }
}

class Counter2Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Counter2PageState();
  }
}

class _Counter2PageState extends State<Counter2Page> {
  int count = 0;

  void _incrementCount() => setState(() {
        count++;
      });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Count2Container(
        state: this,

        ///将自身作为state交给CountContainer
        increment: _incrementCount,

        ///提供修改数据的方法
        child: Counter2());
  }
}

class Counter2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///获取InheritedWidget节点
    Count2Container? state = Count2Container.of(context);

    return Scaffold(
      appBar: AppBar(title: Text("InheritedWidget demo")),
      body: Text(
        'You have pushed the button this many times: ${state?.state.count}',
        //数据的读取
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: state?.state
              ._incrementCount), //数据的修改，修改的逻辑在顶层的state中,限制性，子widget中不能传参修改
    );
  }
}
