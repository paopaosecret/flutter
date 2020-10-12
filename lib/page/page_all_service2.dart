import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstudy/utils/ui_utils.dart';
import 'package:flutterstudy/widget/title_bar.dart';

class AllService3Page extends StatefulWidget {
  AllService3Page({Key key}) : super(key: key);

  @override
  _AllServicePageState createState() => new _AllServicePageState();
}

class _AllServicePageState extends State<AllService3Page>
    with TickerProviderStateMixin {
  TabController _tabController;
  bool isEdit = false;

  @override
  void initState() {
    _tabController = TabController(length: _dataList.length, vsync: this);
    _tabController
        .addListener(() => print("当前点击的是第${_tabController.index}个tab"));
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  ///方式1
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: TitleBar().titleBar(context, '全部服务',
            rightText: isEdit ? "提交" : "编辑", onRightPressed: () {
          setState(() {
            isEdit = !isEdit;
          });
        }),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Visibility(
                visible: isEdit,
                child: Container(
                  height: 200,
                  width: UITools.getScreenWidth(context),
                  color: Color(0xFF00FFFF),
                  child: Text("编辑操作区"),
                ),
              ),
              Visibility(
                visible: !isEdit,
                child: Container(
                  width: UITools.getScreenWidth(context),
                  height: 80,
                  color: Color(0xFF00FF00),
                  child: Text("自己设置"),
                ),
              ),
              Visibility(
                visible: !isEdit,
                child: Container(
                  width: UITools.getScreenWidth(context),
                  height: 140,
                  color: Color(0xFFFF0099),
                  child: Text("最近使用"),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildTab(_tabController);
                    }),
              )
            ]));
  }

  ///方式2
//  @override
//  Widget build(BuildContext context) {
//    List<Widget> children = new List();
//
//    children.add(SliverToBoxAdapter(
//      child: Container(
//          height: 80,
//          width: UITools.getScreenWidth(context),
//          color: Color(0xFF00FFFF),
//          child: new Text('自己编辑的区域')),
//    ));
//
//    children.add(SliverToBoxAdapter(
//      child: Container(
//          height: 80,
//          width: UITools.getScreenWidth(context),
//          color: Color(0xFF00FF00),
//          child: new Text('自己设置')),
//    ));
//
//    children.add(SliverToBoxAdapter(
//      child: Container(
//          height: 120,
//          width: UITools.getScreenWidth(context),
//          color: Color(0xFF0000FF),
//          child: new Text('最近常用')),
//    ));
//
//    ///底部列表
//    children.add(SliverToBoxAdapter(
//      child: Container(
//        child: Column(
//          children: <Widget>[
//            Container(
//              height: 40,
//              color: Color(0xFF990099),
//              child: TabBar(
//                isScrollable: true,
//                labelPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                //TODO:不设置width小就显示不全
//                indicatorPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                indicatorColor: Color(0xFFFF0000),
//                controller: _tabController,
//                labelColor: Color(0xFF999900),
//                labelStyle:
//                    TextStyle(backgroundColor: Color(0xFF00FF00), fontSize: 16),
//                tabs: tabs,
//              ),
//            ),
//            Container(
//              child: TabBarView(
//                controller: _tabController,
//                children: tabBarViews,
//              ),
//            ),
//          ],
//        ),
//      ),
//    ));
//    return Scaffold(
//      appBar: TitleBar().titleBar(context, '全部服务',
//          rightText: isEdit ? "提交" : "编辑", onRightPressed: () {
//        setState(() {
//          isEdit = !isEdit;
//        });
//      }),
//      body: CustomScrollView(
//        shrinkWrap: true,
//        slivers: children,
//      ),
//    );
//  }
}

Widget _buildTab(TabController _tabController) {
  return Column(
    children: <Widget>[
      Container(
        height: 40,
        color: Color(0xFF990099),
        child: TabBar(
          isScrollable: true,
          labelPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          //TODO:不设置width小就显示不全
          indicatorPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          indicatorColor: Color(0xFFFF0000),
          controller: _tabController,
          labelColor: Color(0xFF999900),
          labelStyle:
              TextStyle(backgroundColor: Color(0xFF00FF00), fontSize: 16),
          tabs: tabs,
        ),
      ),
      Container(
        height: 260,
        child: TabBarView(
          controller: _tabController,
          children: tabBarViews,
        ),
      ),
    ],
  );
}

final List _dataList = <String>[
  'Tab0',
  'Tab1',
  'Tab2',
  'Tab3',
  'Tab4',
  'Tab5',
  'Tab6',
].toList();
final tabs = List<Tab>.generate(_dataList.length, (i) {
  return Tab(
    text: _dataList[i],
  );
});

/// 对应上述tab切换后具体需要显示的页面内容
final tabBarViews = List.generate(_dataList.length, (i) {
  if (i == 2) {
    return Center(child: Text("Tab2 content"));
  } else {
    return GridView.builder(
      itemCount: 100, //设置item数量
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, //横轴三个子widget
          childAspectRatio: 2.0 //宽高比为1时，子widget
          ),
      itemBuilder: (BuildContext context, int index) {
        switch (index % 5) {
          case 0:
            return Icon(Icons.ac_unit);
          case 1:
            return Icon(Icons.airport_shuttle);
          case 2:
            return Icon(Icons.all_inclusive);
          case 3:
            return Icon(Icons.beach_access);
          case 4:
            return Icon(Icons.cake);
        }
        return Icon(Icons.free_breakfast);
      },
    );
  }
});
