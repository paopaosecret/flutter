import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstudy/utils/ui_utils.dart';
import 'package:flutterstudy/widget/title_bar.dart';

class AllService3Page extends StatefulWidget {
  AllService3Page({Key? key}) : super(key: key);

  @override
  _AllServicePageState createState() => new _AllServicePageState();
}

class _AllServicePageState extends State<AllService3Page>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool isShowHeaderTab = false;
  ScrollController _scrollController = new ScrollController();
  int dataCount = 4;

  @override
  void initState() {
    dataCount = 4;
    _tabController = TabController(length: _dataList.length, vsync: this);
    _tabController.addListener(() {
      // setState(() {
      //   if(_tabController.index % 2 == 0){
      //     dataCount =  5;
      //   }else{
      //     dataCount = 20;
      //   }
      // });

    });
    _scrollController.addListener(() {
      double currentPosiiton = _scrollController.position.pixels;
      double maxPosition = _scrollController.position.maxScrollExtent;
      setState(() {
        if (currentPosiiton >= 220) {
          isShowHeaderTab = true;
        } else {
          isShowHeaderTab = false;
        }
      });
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
        appBar: TitleBar().titleBar(context, '全部服务', rightText:"提交"),
        body: Column(
          children: <Widget>[
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
                          return Container(
                            width: UITools.getScreenWidth(context),
                            height: 80,
                            color: Color(0xFF00FF00),
                            child: Text("自己设置"),
                          );

                        case 1:
                          return Container(
                            width: UITools.getScreenWidth(context),
                            height: 140,
                            color: Color(0xFFFF0099),
                            child: Text("最近使用"),
                          );

                        case 2:
                          return Container(
                            height: 40,
                            color: Color(0xFF990099),
                            child: TabBar(
                              isScrollable: false,
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
                            height: 61.0 * dataCount,
                            child: TabBarView(
                              controller: _tabController,
                              children: tabBarViews(),
                            ),
                          );

                        case 4:
                          return Visibility(visible: getExpandHeight(context,dataCount) > 0,
                              child: Container(
                                height: getExpandHeight(context, dataCount),
                                color: Color(0xFFFFFFFF),
                              )
                          );
                      }
                      return Container(
                        height: getExpandHeight(context, dataCount),
                        color: Color(0xFFFFFFFF),
                      );
                    },
                  ),
                  Visibility(
                    visible: isShowHeaderTab,
                    child: Container(
                      height: 40,
                      color: Color(0xFF990099),
                      child: TabBar(
                        isScrollable: false,
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
                    ),
                  ),
                  Container(
                    height: 0.5,
                    child: TabBarView(
                      controller: _tabController,
                      children: tabBarViews(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  double getExpandHeight(BuildContext context, int dataCount) {
    //屏幕高 - 状态栏高度 -appbar高 -tabBar高 - item个数高度
    double  expandHeight = UITools.getScreenHeight(context) - 24 - 48 - 40 - dataCount * 61 ;
    print("expandHeight = ${expandHeight}");
    return expandHeight;
  }
}


final List _dataList = <String>[
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


List<Widget> tabBarViews() {
  return List.generate(_dataList.length, (i) {
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
        itemCount: i % 2 == 0 ? 5 : 20);
  });
}
