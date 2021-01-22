import 'package:flutter/material.dart';
import 'package:flutterstudy/bean/service_item_bean.dart';
import 'package:flutterstudy/utils/ui_utils.dart';
import 'package:flutterstudy/widget/toast.dart';

class ScrollTitlePage extends StatefulWidget {
  @override
  _ScrollTitlePageState createState() => _ScrollTitlePageState();
}

class _ScrollTitlePageState extends State<ScrollTitlePage>
    with SingleTickerProviderStateMixin {
  List<ItemBean> dataList;
  double maxTop = 0.0;
  double currentTop = 0.0;
  bool isFrist = true;
  bool zhejie = false;
  double scaleBL = 1.0;
  double translateOffset = 0.0;
  AnimationController controller;
  Animation<double> animation;
  ScrollController scrollController;

  initDataList() {
    if (dataList == null) {
      dataList = new List();
    } else {
      dataList.clear();
    }
    for (int i = 0; i < 5; i++) {
      ItemBean itemBean = new ItemBean();
      itemBean.id = i;
      itemBean.name = "name${i}";
      dataList.add(itemBean);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    scrollController = new ScrollController();
    scrollController.addListener(() {
      scaleBL = (150.0 - scrollController.offset) / 150.0;
      translateOffset = scrollController.offset;
      print("scallBL = ${scaleBL},offset = ${scrollController.offset} ");
      setState(() {});
    });
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
      "Tab1",
      "Tab2",
      "Tab3",
      "Tab4",
    ];
//    initDataList();
    return Scaffold(
      body:DefaultTabController(
        length: _tabs.length,
        child: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  backgroundColor: Colors.red,

                  ///没有leading为true的时候，默认返回箭头，没有leading且为false，则显示title
                  automaticallyImplyLeading: false,

                  ///可以理解为SliverAppBar的背景内容区
                  flexibleSpace: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    if (isFrist) {
                      maxTop = constraints.biggest.height;
                    }

                    return new FlexibleSpaceBar(
                      centerTitle: false,
                      background: Container(
                        padding: EdgeInsets.only(top: 70, left: 15),
                        width: UITools.getScreenWidth(context),
                        color: Colors.red,
                      ),
                    );
                  }),

                  ///SliverAppBar的底部区
                  bottom: PreferredSize(
                    preferredSize: Size(UITools.getScreenWidth(context), 55),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: UITools.getScreenWidth(context),
                          height: 60,
                          color: Colors.red,
                          padding: EdgeInsets.only(top: 10),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                  left: 15,
                                  child: Transform.scale(
                                    scale: scaleBL,
                                    origin: Offset(0, 0),
                                    alignment: Alignment.topLeft,
                                    child: GestureDetector(
                                        onTap: () {
                                          ToastUtils.showToast("标题");
                                        },
                                        child: Text(
                                          "标题",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white),
                                        )),
                                  )),
                              SizedBox(
                                width: 125,
                              ),
                              Positioned(
                                right: 15,
                                child: Transform.scale(
                                  scale: scaleBL,
                                  origin: Offset(0, 0),
                                  alignment: Alignment.topRight,
                                  child: Row(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Icon(
                                            Icons.print,
                                          ),
                                          Text("待回访"),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Icon(
                                            Icons.av_timer,
                                          ),
                                          Text("已收藏"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: UITools.getScreenWidth(context),
                          height: 50,
                          color: Colors.blue,
                          child: TabBar(
                            isScrollable: true,
                            tabs: _tabs
                                .map((String name) => Tab(text: name))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///是否显示在状态栏的下面,false就会占领状态栏的高度
                  primary: true,

                  ///标题是否居中显示
                  centerTitle: false,

                  ///合并的高度，默认是状态栏的高度加AppBar的高度
                  expandedHeight: 150,

                  ///标题栏是否固定,设置为true时，当SliverAppBar内容滑出屏幕时，将始终渲染一个固定在顶部的收起状态
                  pinned: true,

                  ///滑动时是否悬浮
                  floating: false,

                  ///配合floating使用,设置为true时，当手指放开时，SliverAppBar会根据当前的位置进行调整，始终保持展开或收起的状态，此效果在floating=true时生效
                  snap: false,

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
