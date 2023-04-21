import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///自定义 下拉刷新  上拉加载更多组件
class ZListView extends StatefulWidget{
  
  final String title;
  
  ZListView({Key? key, required this.title}) : super(key : key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ZState();
  }
}

class ZState extends State<ZListView>{
  LoadStatus loadStatus = LoadStatus.STATUS_IDEL;
  List<String> list = <String>[];  ///数据源
  String loadText = "加载中...";   ///加载时，显示的文本
  int pageCount = 10;

  ///设置相对于子Widget的padding 属性
  Widget _padAll(Widget widget, var value){
    return new Padding(padding: EdgeInsets.all(value), child: widget);
  }
  Widget _pad(Widget widget, {double? l,double?  t,double?  r,double? b}){
    return new Padding(padding: EdgeInsets.fromLTRB(l ??= 0.0, t ??= 0.0, r ??= 0.0, b ??= 0.0), child: widget);
  }

  ///定义滑动监听
  ScrollController _controller = new ScrollController();

  ///初始化状态   构造方法执行之后调用  只执行一次
  @override
  void initState(){
    //在初始化状态，准备第一页数据
    list.clear();
    for(int i = 1; i <= pageCount; i++){
      list.add("第$i条数据");
    }
    _controller.addListener((){
      print("list.length:${list.length}, pageCount: $pageCount");
      double currentPosition = _controller.position.pixels;
      double maxPosition = _controller.position.maxScrollExtent;
      print("当前位置:$currentPosition , 最大位置：$maxPosition");
      //_controller.position.pixels获取当前位置的像素值
      //_controller.position.maxScrollExtent  获取可滑动的最大位置
      if( currentPosition == maxPosition){
        _getMoreData();
      }
    });
  }
  
  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  ///获取更多数据，然后调用setState让控件进行数据刷新
  Future _getMoreData() async{
    ///先设置状态防止往下拉时就直接加载数据
    if(loadStatus == LoadStatus.STATUS_IDEL){
      setState(() {
        loadText = "加载中...";
        loadStatus = LoadStatus.STATUS_LOADING;
      });
    }
    List<String> moreList = <String>[];
    ///假设数据总共65条，做一个限制
    if(list.length < 45) {
      ///异步准备数据
      moreList = await Future.delayed(new Duration(seconds: 2), () {
        return List.generate(pageCount, (i) {
          return "新增数据" + (list.length + i + 1).toString();
        });
      });
    }

    ///数据请求完成，然后刷新状态
    setState(() {
      if(list.length < 45){
        list.addAll(moreList);
        loadStatus = LoadStatus.STATUS_IDEL;
        loadText = "加载中...";
      }else{
        loadStatus = LoadStatus.STATUS_COMPLETED;
        loadText = "加载完毕";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  new RefreshIndicator(
          backgroundColor: Colors.amber,   //设置下拉刷新的精度条的背景颜色
          onRefresh: _doRefresh,           //设置下拉刷新处理事件
          displacement: 20.0,               //设置下拉刷新的精度条的到listView顶部的距离
          child: ListView.separated(

            controller: _controller,
            itemCount: list.length + 1,
            padding: EdgeInsets.only(top: 0),
            itemBuilder: (BuildContext context, int index) {
              if(index  == list.length){
                return _loadView();
              }else{
                return Container(   ///测试：ListView
                    width: 360,
                    height: 30,
                    color: Colors.white,
                    child: new Text(list[index],
                      textScaleFactor: 1.0, //字体显示的赔率
                      textAlign: TextAlign.center, //文本对齐方式  居中
                      style: TextStyle(
                        fontSize: 16,
                        decoration:TextDecoration.lineThrough, //设置文本划线
                        decorationColor: Colors.yellow,
                      )
                    ), //设置文本划线的颜色

                );
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return divider1;
            },
          ),



    );
  }
  
  Future<void> _doRefresh() async{
    await Future<void>.delayed(Duration(seconds: 2),(){
      print("刷新开始");
      setState(() {
        loadText = "加载中...";
        loadStatus = LoadStatus.STATUS_LOADING;
        list.clear();
        for(int i = 1; i<= pageCount; i++){
          list.add("刷新后的数据$i");
        }
        return null;
      });
    });

  }
  final Widget divider1= Container(width: double.infinity, height: 2.0, color: Colors.yellow);

  Widget _loadView(){
    TextStyle loadTS = TextStyle(
        color: Colors.blue,
        fontSize: 16,
        decoration: TextDecoration.none,
    );
    Widget loadWidget = _pad(Text(loadText, style: loadTS), l:20.0);
    Visibility loadIndicator = new Visibility(
        visible: loadStatus == LoadStatus.STATUS_LOADING ? true : false ,
        child: SizedBox(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.blue)),
          width: 20.0,
          height: 20.0,
        )
    );
    return _pad(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            loadIndicator, loadWidget
          ],
        ),t:10.0, b:10.0
    );
  }
}

///刷新过程状态
enum LoadStatus{
  STATUS_LOADING,          ///正在加载中
  STATUS_COMPLETED,        ///加载完成
  STATUS_IDEL              ///空闲状态
}