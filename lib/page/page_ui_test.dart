import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstudy/page/my_store.dart';
import 'package:flutterstudy/page/z_listview.dart';

class UITest extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Column( //垂直布局
            mainAxisAlignment: MainAxisAlignment.start,  ///主轴方向对齐方式，Column主轴为垂直方向，ROW主轴为水平方向
            crossAxisAlignment: CrossAxisAlignment.start, ///纵轴方向对齐方式，Column纵轴为水平方向，ROW纵轴为垂直方向
            mainAxisSize: MainAxisSize.max,         //主轴方向尺寸
            children: <Widget>[
              Container(
                child: Text("文本框组件纵轴方向对齐方式，Column纵轴为水平方向，ROW纵轴为垂直方向纵轴方向对齐方式，Column纵轴为水平方向，ROW纵轴为垂直方向",
                    softWrap: true,
//                  textAlign: TextAlign.center,
//                  overflow: TextOverflow.ellipsis,
                    style: TextStyle(            //设置文本样式
                        color: Colors.redAccent,   ///设置文字颜色
                        fontSize: 16,              ///设置文字大小
    //              height: 0.9,               ///该属性用于指定行高，但它并不是一个绝对值，而是一个因子，具体的行高等具体的行高等于fontSize*height。
                        fontFamily: "Courier",     ///设置字体
                        background: new Paint()    ///设置背景
                          ..color=Colors.yellow,   ///..为级联操作符  为对象属性设置
                        decoration:TextDecoration.lineThrough,     ///  文本画线  下划线  或者删除线
                        decorationStyle: TextDecorationStyle.wavy  ///线条样式 画一条直线 solid,  画两条线double,画圆点虚线dotted, 画破折号虚线dashed, 画波浪线wavy
                    )
                ),
              ),
              Container(   ///测试：ListView
                width: 360,
                height: 160,
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20.0),  //设置padding
                  children: <Widget>[
                    Center(
                      child: ClipPath(
                        clipper: TrianglePath(),
                        child: Container(
                          width: 10,
                          height: 7,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    Container(
                      height:100,
                      width: 100,
                      padding: EdgeInsets.all(5),     //设置容器内部内边距
                      margin: EdgeInsets.only(top:10), //设置容器距离外部边距
                      decoration: BoxDecoration(
                        color: Color(0xFF00FF00),  //设置容器填充背景
                        shape: BoxShape.circle,  //设置容器形状，当是circle是不能设置圆角
//                        shape: BoxShape.rectangle,
//                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(   //设置容器表框和颜色
                          width: 2,
                          color: Color(0xFFFF0000),
                        ),
                        gradient: LinearGradient(   //设置渐变 RadialGradient:环形渐变，从里到外   LinearGradient线性渐变：可以设置beagin
                          colors:[
                            Color(0xFFFF99FF),
                            Color(0xFFFF33FF),
                          ],
                          begin: Alignment.topCenter,   //RadialGradient渐变没有此属性
                          end: Alignment.bottomCenter,  //RadialGradient渐变没有此属性
                        ),
                      ),
                      child: new IconButton(
                          icon:  Image.asset("images/title_back.png",width:30,height:30),
                          onPressed: () {
                            List<ItemBean> list = new List();
                            for(int i = 0; i < 10; i++){
                              ItemBean bean = new ItemBean();
                              bean.phone = "13510577981";
                              bean.address = "北京朝阳酒仙桥";
                              bean.name = "跑腿小店(酒仙桥店)";
                              bean.id = "3282856343633199237";
                              bean.state = 2;        //状态
                              bean.type = 1;         //类型
                              bean.cateName = "保洁清洗";
                              list.add(bean);
                            }
                            Navigator.of(context).pushNamed("my_store", arguments: list);
                          }
                      ),
                    ),
                    const Text('I\'m dedicating every day to you', overflow: TextOverflow.ellipsis, style: TextStyle(  color: Colors.redAccent, fontSize: 16,)),
                    const Text('Domestic life was never quite my style', overflow: TextOverflow.ellipsis, style: TextStyle(  color: Colors.redAccent, fontSize: 16,)),
                    const Text('When you smile, you knock me out, I fall apart', overflow: TextOverflow.ellipsis, style: TextStyle(  color: Colors.redAccent, fontSize: 16,)),
                    const Text('And I thought I was so smart', overflow: TextOverflow.ellipsis, style: TextStyle(  color: Colors.redAccent, fontSize: 16,)),
                    const Text('I\'m dedicating every day to you', overflow: TextOverflow.ellipsis, style: TextStyle(  color: Colors.redAccent, fontSize: 16,)),
                    const Text('Domestic life was never quite my style', overflow: TextOverflow.ellipsis, style: TextStyle(  color: Colors.redAccent, fontSize: 16,)),
                    const Text('When you smile, you knock me out, I fall apart', overflow: TextOverflow.ellipsis, style: TextStyle(  color: Colors.redAccent, fontSize: 16,)),
                    const Text('And I thought I was so smart', overflow: TextOverflow.ellipsis, style: TextStyle(  color: Colors.redAccent, fontSize: 16,)),
                  ],
                ),
              ),

              Container(   ///测试：ListView
                width: 360,
                height: 130,

                child: ListView.separated(
                  padding: EdgeInsets.only(top: 0),   //设置吸顶
                  itemCount: 20,   //设置item数量
                  itemBuilder: (BuildContext context, int index) {
                    return Text('Index${index}Domestic life was never quite my styleDomestic life was never quite my styleDomestic life was never quite my style',
                        softWrap: true,
//                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(  color: Colors.redAccent, fontSize: 16,));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return index%2==0?divider1:divider2;
                  },
                ),
              ),
              Container(   ///测试：ListView
                width: 360,
                height: 100,
                color: Color.fromARGB(255, 255, 255, 255),
                child: GridView.builder(
                  itemCount: 20,   //设置item数量
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, //横轴三个子widget
                      childAspectRatio: 2.0 //宽高比为1时，子widget
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    switch(index % 5){
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
                ),
              ),
              Container(   ///测试：ListView
                width: 360,
                height: 220,
                color: Color.fromARGB(255, 255, 255, 255),
                child: ZListView(key: Key("list"), title: "test",),
              )
            ],
          ),
        )
    );

  }
  final Widget divider1=Divider(color: Colors.blue,);
  final Widget divider2=Divider(color: Colors.green);
}

class TrianglePath extends CustomClipper<Path>{

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width/2, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}