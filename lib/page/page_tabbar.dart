// 需要显示的tab子项集合
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstudy/utils/ui_utils.dart';
import 'package:flutterstudy/widget/title_bar.dart';

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

class TabBarPage extends StatefulWidget {
  @override
  State createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _controller = new ScrollController();
  int index = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      index = (_tabController.index + 1) % tabs.length;
      print("当前点击的是第${_tabController.index}个tab");
    });
    index = _tabController.index + 1;

    _controller.addListener(() {
      double currentPosiiton = _controller.position.pixels;
      double maxPosition = _controller.position.maxScrollExtent;
      print("当前位置:$currentPosiiton , 最大位置：$maxPosition");
      int index = (currentPosiiton / 240).round();
      _tabController.animateTo(index % tabs.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar().titleBar(context, 'TabBar', rightText: "编辑",
          onRightPressed: () {
            setState(() {
              _tabController.animateTo(index);
            });
          }),
      body: Container(
//        margin: EdgeInsets.only(top: 100),
        child: Column(
          children: <Widget>[
            Container(
              height: 40,
              color: Color(0xFF990099),
              child: TabBar(
                isScrollable: true,
                labelPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                //TODO:不设置width小就显示不全
                indicatorPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                indicatorColor: Color(0xFFFFFF00),
                controller: _tabController,
                labelColor: Color(0xFF999900),
                labelStyle:
                TextStyle(backgroundColor: Color(0xFF00FF00), fontSize: 16),
                tabs: tabs,
              ),
            ),
            Stack(alignment: AlignmentDirectional.topStart, children: <Widget>[
              Container(
                height: 260,
                child: TabBarView(
                  controller: _tabController,
                  children: tabBarViews,
                ),
              ),

              Container(
                height: 260,
                color: Color(0xFF0000FF),
                child: ListView.builder(
                    controller: _controller,
                    itemCount: 30,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Container(
                            width: UITools.getScreenWidth(context),
                            height: 80,
                            color: Color(0xFF00FF00),
                            child: Center(child: Text("第${index}项")),
                          ),
                          Container(
                            width: UITools.getScreenWidth(context),
                            height: 1,
                            color: Color(0xFF00FFFF),
                          ),
                        ],
                      );
                    }),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
