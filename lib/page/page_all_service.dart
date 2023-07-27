import 'package:flutter/material.dart';
import 'package:flutterstudy/bean/service_item_bean.dart';
import 'package:flutterstudy/page/page_draggable.dart';
import 'package:flutterstudy/utils/ui_utils.dart';

class AllServicePage extends StatefulWidget {
  @override
  _AllServiceState createState() => _AllServiceState();
}

class _AllServiceState extends State<AllServicePage> {
  bool isEdit = false;
  bool isDown = false;
  List<ItemBean> dataList = <ItemBean>[];
  double maxTop = 0.0;
  double currentTop = 0.0;
  bool isFrist = true;

  initDataList() {
    dataList.clear();
    for (int i = 0; i < 5; i++) {
      ItemBean itemBean = ItemBean(id:i, name:"name${i}");
      dataList.add(itemBean);
    }
  }

  @override
  void initState() {
    super.initState();
    initDataList();
  }

  double calcExpandedHeight() {
    if (dataList.length < 5) {
      return 250.0;
    } else if (dataList.length < 9) {
      return 300.0;
    } else {
      return 350.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    var _tabs = <String>[];
    _tabs = <String>[
      "Tab 1",
      "Tab 2",
      "Tab 3",
      "Tab 4",
      "Tab 5",
      "Tab 6",
    ];
//    initDataList();
    return Scaffold(
      body:

          /// 加TabBar
          DefaultTabController(
        length: _tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  ///左侧的图标或文字，多为返回箭头
                  leading: new IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      setState(() {
                        if (dataList.length == 0) {
                          isDown = false;
                        }
                        if (dataList.length < 10 && !isDown) {
                          ItemBean itemBean = new ItemBean(id:dataList
                              .length, name:"name${dataList.length}");
                          dataList.add(itemBean);
                        } else {
                          isDown = true;
                          dataList.removeLast();
                        }
                      });
                    },
                  ),

                  ///没有leading为true的时候，默认返回箭头，没有leading且为false，则显示title
                  automaticallyImplyLeading: true,

                  ///标题
                  title: const Text('标题'),

                  ///标题栏右侧的操作栏
                  actions: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if(!isEdit){
                          if(currentTop != maxTop){
                            return;
                          }
                        }
                        setState(() {
                          isEdit = !isEdit;
                          print("更多${isEdit}");
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(right: 10, top: 15),
                        child: Text(
                          isEdit ? "保存" : "编辑",
                          style:
                              TextStyle(color: Color(0xFFFFFFFF), fontSize: 18),
                        ),
                      ),
                    ),
                  ],

                  ///可以理解为SliverAppBar的背景内容区
                  flexibleSpace: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    if(isFrist){
                      maxTop = constraints.biggest.height;
                      isFrist = false;
                    }
                    currentTop = constraints.biggest.height;
                    print('top = ${currentTop}, constraints=${constraints.toString()}');

                    return new FlexibleSpaceBar(
                      centerTitle: false,
                      background: new Container(
                        color: Color(0xFFFFFF00), //打开可以测试区域
                        margin: EdgeInsets.only(top: 80, bottom: 60),
                        child: new Column(
                          children: <Widget>[
                            Visibility(
                              visible: isEdit,
                              child: Container(
                                  ///marginTop + 状态栏高度（maxTop - 310）
                                  height: calcExpandedHeight() - (80 + maxTop - 310),
                                  width: UITools.getScreenWidth(context),
                                  color: Color(0xFF009977),
                                  child: GridViewPage3(dataList)),
                            ),
                            Visibility(
                              visible: !isEdit,
                              child: Container(
                                  height: 80,
                                  width: UITools.getScreenWidth(context),
                                  color: Color(0xFF00FFFF),
                                  child: new Text('自己设置')),
                            ),
                            Visibility(
                              visible: !isEdit,
                              child: Container(
                                  height: maxTop - 140 - 80,  //最大高度减去margin 减去 上面自己设置模块的区域80高度
                                  width: UITools.getScreenWidth(context),
                                  color: Color(0xFF9999ee),
                                  child: new Text('最近常用')),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                  ///SliverAppBar的底部区
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                  ),

                  ///是否显示在状态栏的下面,false就会占领状态栏的高度
                  primary: true,

                  ///标题是否居中显示
                  centerTitle: false,

                  ///合并的高度，默认是状态栏的高度加AppBar的高度
                  expandedHeight: !isEdit ? 310.0 : calcExpandedHeight(),

                  ///标题栏是否固定,设置为true时，当SliverAppBar内容滑出屏幕时，将始终渲染一个固定在顶部的收起状态
                  pinned: true,

                  ///滑动时是否悬浮
                  floating: isEdit,

                  ///配合floating使用,设置为true时，当手指放开时，SliverAppBar会根据当前的位置进行调整，始终保持展开或收起的状态，此效果在floating=true时生效
//                  snap: isEdit,

                  ///是否显示阴影，直接取值innerBoxIsScrolled，展开不显示阴影，合并后会显示
                  elevation: 10,
                  forceElevated: innerBoxIsScrolled,
                ),
              ),
            ];
          },
          body: TabBarView(
            ///
            children: _tabs.map((String name) {
              //SafeArea 适配刘海屏的一个widget
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      key: PageStorageKey<String>(name),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(10.0),
                          sliver: SliverFixedExtentList(
                            itemExtent: 50.0, //item高度或宽度，取决于滑动方向
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return ListTile(
                                  title: Text('Item $index'),
                                );
                              },
                              childCount: 30,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
