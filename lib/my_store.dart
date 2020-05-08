import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstudy/widget/toast.dart';
import 'ui_utils.dart';

class MyStore extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StoreState();
  }
}

class StoreState extends State<MyStore> {
  LoadStatus loadStatus = LoadStatus.STATUS_IDEL;
  String loadText = "——————已经到底了——————";

  ///加载时，显示的文本
  List<ItemBean> dataList = new List();
  int pageCount = 10;
  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    dataList.clear();
    for (int i = 0; i < 5; i++) {
      ItemBean bean = new ItemBean();
      bean.phone = "13510577981";
      bean.address = "北京朝阳酒仙桥";
      bean.name = "跑腿小店(酒仙桥店)";
      bean.id = "3282856343633199237";
      bean.state = 2; //状态
      if (i == 1) {
        bean.type = 1;
      } else {
        bean.type = 2;
      }
      //类型
      bean.cateName = "保洁清洗";
      dataList.add(bean);
    }
    _controller.addListener(() {
      double currentPosiiton = _controller.position.pixels;
      double maxPosition = _controller.position.maxScrollExtent;
      print("当前位置:$currentPosiiton , 最大位置：$maxPosition");
      if (currentPosiiton == maxPosition) {
        _getMoreData();
      }
    });
  }

  ///获取更多数据，然后调用setState让控件进行数据刷新
  Future _getMoreData() async {
    ///先设置状态防止往下拉时就直接加载数据
    if (loadStatus == LoadStatus.STATUS_IDEL) {
      setState(() {
        loadText = "加载中...";
        loadStatus = LoadStatus.STATUS_LOADING;
      });
    }
    List<ItemBean> moreList;

    ///假设数据总共65条，做一个限制
    if (dataList.length < 45) {
      ///异步准备数据
      moreList = await Future.delayed(new Duration(seconds: 2), () {
        return List.generate(pageCount, (i) {
          ItemBean bean = new ItemBean();
          bean.phone = "13510577981";
          bean.address = "北京朝阳酒仙桥";
          bean.name = "跑腿小店($i店)";
          bean.id = "3282856343633199237";
          bean.state = 2; //状态
          if (i == 1) {
            bean.type = 1;
          } else {
            bean.type = 2;
          }
          bean.cateName = "保洁清洗";
          return bean;
        });
      });
    }

    ///数据请求完成，然后刷新状态
    setState(() {
      print("add start dataList.length: ${dataList.length}");
      if (dataList.length < 45) {
        dataList.addAll(moreList);
        loadStatus = LoadStatus.STATUS_IDEL;
        loadText = "加载中...";
        print("add start dataList.length: ${dataList.length}");
      } else {
        loadStatus = LoadStatus.STATUS_COMPLETED;
        loadText = "——————已经到底了——————";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '我的店铺信息',
          style: TextStyle(color: Colors.black87, fontSize: 20),
        ),
        centerTitle: true,
        leading: new IconButton(
            icon: Image.asset("images/title_back.png", width: 30, height: 30),
            onPressed: () async {
              ///使用路由表方式
              Navigator.pop(context, "我是返回值1");
            }),
        backgroundColor: Color(0xFFFFFFFF),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          divider2,
          Expanded(
            flex: 50,
            child: new RefreshIndicator(
                backgroundColor: Colors.amber, //设置下拉刷新的精度条的背景颜色
                onRefresh: _doRefresh, //设置下拉刷新处理事件
                displacement: 40.0, //设置下拉刷新的精度条的到listView顶部的距离
                child: ListView.separated(
                  controller: _controller,
                  itemCount: dataList.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == dataList.length) {
                      return _loadView();
                    } else {
                      return _buildItem(dataList[index]);
                    }
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return divider1;
                  },
                )),
          ),
          Expanded(
            flex: 5,
            child: Container(
                color: Colors.white,
                width: double.infinity,
                padding: EdgeInsets.all(8),
                child: Material(
                    color: Colors.redAccent,
                    //设置控件的背景色
                    borderRadius: BorderRadius.circular(5.0),
                    //设置矩形的圆角弧度，具体根据 UI 标注为准
                    shadowColor: Colors.grey,
                    //可以设置 阴影的颜色
                    elevation: 1.0,
                    //安卓中的井深(大概就是阴影颜色的深度吧
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "新增分店",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 18.0),
                      ),
                    ))),
          ),
        ],
      ),
    );
  }

  //通过数据构建item
  Widget _buildItem(ItemBean bean) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          divider1,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              pad(
                  Text(bean.name,
                      style: TextStyle(
                        fontSize: 14,
                      )),
                  l: 15,
                  t: 10),
              visible(
                  pad(
                      Material(
                        color: Colors.deepOrangeAccent,
                        //设置控件的背景色
                        child: pad(
                            Text(
                              bean.type == 1 ? "总店" : "分店",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                            ),
                            l: 3.0,
                            r: 3.0,
                            b: 1),
                        borderRadius: BorderRadius.circular(2.0),
                        //设置矩形的圆角弧度，具体根据 UI 标注为准
                        shadowColor: Colors.grey,
                        //可以设置 阴影的颜色
                        elevation: 5.0, //安卓中的井深(大概就是阴影颜色的深度吧
                      ),
                      l: 5,
                      t: 12),
                  bean.type == 1 ? true : false),
              pad(
                  Material(
                    color: Colors.lightBlue,
                    //设置控件的背景色
                    child: pad(
                        Text(
                          bean.cateName,
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                        l: 3.0,
                        r: 3.0,
                        b: 1),
                    borderRadius: BorderRadius.circular(2.0),
                    //设置矩形的圆角弧度，具体根据 UI 标注为准
                    shadowColor: Colors.grey,
                    //可以设置 阴影的颜色
                    elevation: 5.0, //安卓中的井深(大概就是阴影颜色的深度吧
                  ),
                  l: 5,
                  t: 12),
            ],
          ),
          pad(
              Text(
                bean.phone ?? "电话信息待补充",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              l: 15,
              t: 5),
          pad(
              Text(
                bean.address ?? "地址信息待补充",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              l: 15,
              t: 5),
          pad(divider2, t: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              pad(
                  Image.asset("images/icon_shop_info_delete.png",
                      width: 15, height: 15),
                  t: 18),
              pad(
                  GestureDetector(
                    onTap: () {
                      showCustomDialog(
                          context, "删除提醒", "您确定删除当前分店信息？", "取消", "删除", () {
                        Navigator.pop(context);
                      }, () {
                        ToastUtils.showToast('删除店铺信息');
                        Navigator.pop(context);
                      });
                    },
                    child: Text(
                      "删除",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ),
                  r: 20,
                  t: 15,
                  b: 15),
                  pad(Image.asset("images/icon_shop_info_edit.png",
                        width: 15, height: 15),t:18
                  ),
              pad(
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed("fragment_me");
                    },
                    child: Text(
                      "编辑",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ),
                  r: 15,
                  t: 15,
                  b: 15),
            ],
          )
        ],
      ),

      //  child: Container
    );
  }

  Widget _loadView() {
    TextStyle loadTS = TextStyle(
      color:
          loadStatus == LoadStatus.STATUS_LOADING ? Colors.blue : Colors.grey,
      fontSize: 16,
      decoration: TextDecoration.none,
    );
    Widget loadWidget = pad(Text(loadText, style: loadTS), l: 20.0);
    Visibility loadIndicator = visible(
        SizedBox(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blue)),
          width: 20.0,
          height: 20.0,
        ),
        loadStatus == LoadStatus.STATUS_LOADING ? true : false);

    return pad(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[loadIndicator, loadWidget],
        ),
        t: 10.0,
        b: 10.0);
  }

  Future<void> _doRefresh() async {
    await Future<void>.delayed(Duration(seconds: 2), () {
      print("刷新开始");
      setState(() {
        loadText = "加载中...";
        loadStatus = LoadStatus.STATUS_LOADING;
        dataList.clear();
        for (int i = 1; i <= pageCount; i++) {
          ItemBean bean = new ItemBean();
          bean.phone = "13510577981";
          bean.address = "北京朝阳酒仙桥";
          bean.name = "跑腿小店(刷新$i)";
          bean.id = "3282856343633199237";
          bean.state = 2; //状态
          if (i == 1) {
            bean.type = 1;
          } else {
            bean.type = 2;
          }
          bean.cateName = "保洁清洗";
          dataList.add(bean);
        }
        return null;
      });
    });
  }

  final Widget divider1 =
      Container(width: double.infinity, height: 10.0, color: Color(0xFFF3F3F3));
  final Widget divider2 =
      Container(width: double.infinity, height: 1, color: Color(0xFFF3F3F3));
}

class ItemBean {
  String address; //		北京朝阳酒仙桥
  String phone; //	13510577981
  String name; //		跑腿小店(酒仙桥店)
  String id; // 3282856343633199237
  int state; //状态
  int type; //类型
  String cateName; //保洁清洗
}

///刷新过程状态
enum LoadStatus {
  STATUS_LOADING,

  ///正在加载中
  STATUS_COMPLETED,

  ///加载完成
  STATUS_IDEL

  ///空闲状态
}
