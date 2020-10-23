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
  bool isShowHeaderTab = false;
  bool isScroll = false;
  bool isTabChange = false;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    _tabController = TabController(length: _dataList.length, vsync: this);
    _tabController.addListener(() {

      if(!isScroll){
        isTabChange = true;
        double y = _tabController.index * 100.0 + 220;
        setState(() {
          _scrollController.animateTo(y, duration: Duration(milliseconds: 200), curve: Curves.ease);
        });

        print("当前点击的是第${_tabController.index}个tab");
        isTabChange = false;
      }

    });
    _scrollController.addListener(() {
      if(!isTabChange){
        isScroll = true;
        double currentPosiiton = _scrollController.position.pixels;
        double maxPosition = _scrollController.position.maxScrollExtent;
        setState(() {
          if (currentPosiiton >= 220) {
            isShowHeaderTab = true;
          } else {
            isShowHeaderTab = false;
          }
        });
        if(currentPosiiton > 200){
          int index = ((currentPosiiton - 220) / 100).round();
          _tabController.animateTo(index % tabs.length);
          print("当前位置:$currentPosiiton , 最大位置：$maxPosition");
        }
        isScroll = false;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          children: <Widget>[
            Visibility(
              visible: isEdit,
              maintainSemantics: true,
              maintainSize: true,
              maintainState: true,
              maintainAnimation: true,
              child: Container(
                height: isEdit ? 200 : 0.1,
                width: UITools.getScreenWidth(context),
                color: Color(0xFF00FFFF),
                child: Text("编辑操作区"),
              ),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    padding: EdgeInsets.all(0),
                    //设置吸顶
                    itemCount: 5,
                    //设置item数量
                    itemBuilder: (BuildContext context, int index) {
                      switch (index) {
                        case 0:
                          return Visibility(
                            visible: !isEdit,
                            maintainSemantics: true,
                            maintainSize: true,
                            maintainState: true,
                            maintainAnimation: true,
                            child: Container(
                              width: UITools.getScreenWidth(context),
                              height: !isEdit ? 80 : 0.1,
                              color: Color(0xFF00FF00),
                              child: Text("自己设置"),
                            ),
                          );

                        case 1:
                          return Visibility(
                            visible: !isEdit,
                            maintainSemantics: true,
                            maintainSize: true,
                            maintainState: true,
                            maintainAnimation: true,
                            child: Container(
                              width: UITools.getScreenWidth(context),
                              height: !isEdit ? 140 : 0.1,
                              color: Color(0xFFFF0099),
                              child: Text("最近使用"),
                            ),
                          );
                        case 2:
                          return Container(
                            height: 40,
                            color: Color(0xFF990099),
                            child: TabBar(
                              isScrollable: true,
                              labelPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              //TODO:不设置width小就显示不全
                              indicatorPadding:
                                  EdgeInsets.fromLTRB(10, 0, 10, 0),
                              indicatorColor: Color(0xFFFFFF00),
                              controller: _tabController,
                              labelColor: Color(0xFF999900),
                              labelStyle: TextStyle(
                                  backgroundColor: Color(0xFF00FF00),
                                  fontSize: 16),
                              tabs: tabs,
                            ),
                          );
                        case 3:
                          return Container(
                            height: 0.5,
                            child: TabBarView(
                              controller: _tabController,
                              children: tabBarViews,
                            ),
                          );
                        default:
                          return ListView.separated(
                              shrinkWrap: true,
                              physics: new NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                    height: 60,
                                    color: Color(0xFF00FF00),
                                    child: Center(child: Text("第${index}项")));
                              },
                              separatorBuilder: (context, index) {
                                return Container(
                                  height: 1,
                                  color: Color(0xFF0000FF),
                                );
                              },
                              itemCount: 20);
                      }
                    },
                  ),
                  Visibility(
                    visible: isEdit || isShowHeaderTab,
                    child: Container(
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
                        labelStyle: TextStyle(
                            backgroundColor: Color(0xFF00FF00), fontSize: 16),
                        tabs: tabs,
                      ),
                    ),
                  ),
                  Container(
                    height: 0.5,
                    child: TabBarView(
                      controller: _tabController,
                      children: tabBarViews,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

final Widget divider1 = Divider(
  color: Colors.blue,
  height: 1,
);

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
  return Container(height: 0.5, color: Color(0xFFFFFFFF));
});
