import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterstudy/utils/ui_utils.dart';
import 'package:flutterstudy/widget/default_loading_layout.dart';
import 'package:flutterstudy/widget/pull_to_refresh_widget.dart';
import 'package:flutterstudy/widget/toast.dart';

class ShangjiHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShangjiHomePageState();
  }
}

final List _dataList = <String>[
  'Tab1',
  'Tab2',
  'Tab3',
  'Tab4',
].toList();

class _ShangjiHomePageState extends State<ShangjiHomePage>
    with SingleTickerProviderStateMixin {

  double scaleBL = 1.0;
  int isSelect = 1;
  bool isShowTitle = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    });
  }
  /// 列表头部
  DefaultRefreshHeaderWidget _listViewHeader(BuildContext context) {
    return DefaultRefreshHeaderWidget();
  }
  /// 列表底部
  Widget _listViewFooter(BuildContext context) {
    return Visibility(
      child: new Container(
        margin: EdgeInsets.only(top: 5, bottom: 10),
        alignment: Alignment.center,
        child: new Center(
          child: new Row(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "加载更多...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.normal,
                      fontSize: 12.0),
                ),
                Container(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 1.0),
                )
              ]),
        ),
      ),
    );
  }

  /// 刷新数据
  Future<void> _doRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {});
    ToastUtils.showToast("下拉");
  }


  void _scrollListener(double scrollPixel){
    print("currentPosition: ${scrollPixel}");

    if(scrollPixel >= 0 && scrollPixel < 50){
      scaleBL = (200.0 - scrollPixel) / 200.0;
      isShowTitle = false;
      setState(() {});
    }else if(scrollPixel > 50){
      isShowTitle = true;
      setState(() {});
    }else if(scrollPixel < 0){
      isShowTitle = false;
      scaleBL = 1.0;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            PullToRefreshWidget(
              isLoadMoreEnable: true,
              isRefreshEnable: true,
              onRefresh: _doRefresh,
              onLoadMore: () async {
                ToastUtils.showToast("上拉");
              },
              headerBuilder:_listViewHeader,
              footerBuilder: _listViewFooter,
              scrollNotify: _scrollListener,
              child:
              ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                //设置吸顶
                itemCount: 20 + 2,
                //设置item数量
                itemBuilder: (BuildContext context, int index) {
                  switch (index) {
                    case 0:
                      return Container(width: UITools.getScreenWidth(context),
                      height: 70,
                      color: Colors.white,);
                    case 1:
                      return  Container(
                        width: UITools.getScreenWidth(context),
                        height: 60,
                        color: Color(0xFFF2F2F2),
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
                                          color: Color(0xFF333333),),
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
                      );

                    case 2:
                      return Container(
                        width: UITools.getScreenWidth(context),
                        height: 50,
                        padding: EdgeInsets.only(left: 15),
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                isSelect = 1;
                                setState(() {

                                });
                              },
                              child: Column(
                                children: <Widget>[
                                  Text("全部", style: TextStyle(
                                      fontSize: 15, color: Color(0xFF333333)
                                  ),),
                                  SizedBox(height: 3,),
                                  Visibility(
                                    visible: isSelect == 1,
                                    child: Container(
                                      width: 20,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFF552E),
                                        borderRadius: BorderRadius.circular(2.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20,),
                            GestureDetector(
                              onTap: (){
                                isSelect = 2;
                                setState(() {

                                });
                              },
                              child: Column(
                                children: <Widget>[
                                  Text("新商机", style: TextStyle(
                                      fontSize: 15, color: Color(0xFF999999)
                                  ),),
                                  SizedBox(height: 3,),
                                  Visibility(
                                    visible: isSelect == 2,
                                    child: Container(
                                      width: 30,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFF552E),
                                        borderRadius: BorderRadius.circular(2.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20,),
                            GestureDetector(
                              onTap: (){
                                isSelect = 3;
                                setState(() {

                                });
                              },
                              child: Column(
                                children: <Widget>[
                                  Text("跟进中", style: TextStyle(
                                      fontSize: 15, color: Color(0xFF999999)
                                  ),),
                                  SizedBox(height: 3,),
                                  Visibility(
                                    visible: isSelect == 3,
                                    child: Container(
                                      width: 30,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFF552E),
                                        borderRadius: BorderRadius.circular(2.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20,),
                            GestureDetector(
                              onTap: (){
                                isSelect = 4;
                                setState(() {

                                });
                              },
                              child: Column(
                                children: <Widget>[
                                  Text("已成单", style: TextStyle(
                                      fontSize: 15, color: Color(0xFF999999)
                                  ),),
                                  SizedBox(height: 3,),
                                  Visibility(
                                    visible: isSelect == 4,
                                    child: Container(
                                      width: 30,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFF552E),
                                        borderRadius: BorderRadius.circular(2.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );

                    default :
                      return Container(
                          height: 60,
                          color: Color(0xFF00FF00),
                          child: Center(child: Text("第${index}项")));
                  }
                },
              ),
            ),

            Visibility(
              visible: isShowTitle,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: UITools.getScreenWidth(context),
                      height: 30,
                      color: Colors.white,
                    ),
                    Container(
                      width: UITools.getScreenWidth(context),
                      height: 60,
                      color: Color(0xFFF2F2F2),
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
                                        color: Color(0xFF333333),),
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
                      color: Color(0xFFFFFFFF),
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              isSelect = 1;
                              setState(() {

                              });
                            },
                            child: Column(
                              children: <Widget>[
                                Text("全部", style: TextStyle(
                                    fontSize: 15, color: Color(0xFF333333)
                                ),),
                                SizedBox(height: 3,),
                                Visibility(
                                  visible: isSelect == 1,
                                  child: Container(
                                    width: 20,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF552E),
                                      borderRadius: BorderRadius.circular(2.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20,),
                          GestureDetector(
                            onTap: (){
                              isSelect = 2;
                              setState(() {

                              });
                            },
                            child: Column(
                              children: <Widget>[
                                Text("新商机", style: TextStyle(
                                    fontSize: 15, color: Color(0xFF999999)
                                ),),
                                SizedBox(height: 3,),
                                Visibility(
                                  visible: isSelect == 2,
                                  child: Container(
                                    width: 30,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF552E),
                                      borderRadius: BorderRadius.circular(2.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20,),
                          GestureDetector(
                            onTap: (){
                              isSelect = 3;
                              setState(() {

                              });
                            },
                            child: Column(
                              children: <Widget>[
                                Text("跟进中", style: TextStyle(
                                    fontSize: 15, color: Color(0xFF999999)
                                ),),
                                SizedBox(height: 3,),
                                Visibility(
                                  visible: isSelect == 3,
                                  child: Container(
                                    width: 30,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF552E),
                                      borderRadius: BorderRadius.circular(2.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20,),
                          GestureDetector(
                            onTap: (){
                              isSelect = 4;
                              setState(() {

                              });
                            },
                            child: Column(
                              children: <Widget>[
                                Text("已成单", style: TextStyle(
                                    fontSize: 15, color: Color(0xFF999999)
                                ),),
                                SizedBox(height: 3,),
                                Visibility(
                                  visible: isSelect == 4,
                                  child: Container(
                                    width: 30,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF552E),
                                      borderRadius: BorderRadius.circular(2.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
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
        itemCount: 20);
  });
}
final tabs = List<Tab>.generate(_dataList.length, (i) {
  return Tab(
    text: _dataList[i],
  );
});
