import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstudy/widget/marquee.dart';
import '../utils/ui_utils.dart';

class NewPage extends StatelessWidget {
  Widget _listItemBuilder(BuildContext context, int index){
    return Container(
      width: 360,
      height: 46,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Image.network("https://accounts.processon.com/uphoto/1/98/58aa4919e4b07158582714ea.png"
          ,width: 30,height: 30,),
          SizedBox(height: 16.0), // 图片下面预留的高度
          Text(
              "title$index",
              style:Theme.of(context).textTheme.titleLarge
          ),
          Text(
              "作者",
              style:Theme.of(context).textTheme.subtitle1
          ),
        ],
      ), // 从上到下排列的容器
    );
  }

  @override
  Widget build(BuildContext context) {
    //获取路由参数
    var args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args),
        leading: new IconButton(
            icon:  Image.asset("images/title_back.png",width:30,height:30),
            onPressed: () {
              //导航到新路由
              Navigator.pop( context, "我是返回值1");
            }
        ),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 360,
                height: 46,
                child: Marquee(3, _listItemBuilder)
              ),
              new IconButton(
                icon:  Image.asset("images/title_back.png",width:30,height:30),
                onPressed: () {
                  //导航到新路由
                  Navigator.of(context).pushNamed("ui_test");
                }
              ),

              Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child:  Container(
                      height: 30.0,
                      color: Colors.red,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child:  pad(
                      Container(
                        height: 30.0,
                        color: Colors.blue,
                      ),l:5
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child:  Container(
                      height: 30.0,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              Wrap(
                spacing: 5, //主轴方向间距
                runSpacing: 10,  //纵轴方向间距
                alignment: WrapAlignment.end, //主轴方向对齐方式
                runAlignment: WrapAlignment.end,
                direction: Axis.horizontal,
                children: <Widget>[
                  new Chip(
                    backgroundColor: Colors.yellow,
                    avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('A')),
                    label: new Text('A'),
                  ),
                  new Chip(
                    avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('M')),
                    label: new Text('Lafayette'),
                  ),
                  new Chip(
                    label: Container(
                      height: 20,
                      width: 80,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:<Widget>[
                            new Text('Mulligan'),
                            new CircleAvatar(backgroundColor: Colors.blue, child: Text('H')),
                          ],
                      ),
                    ),
                  ),
                  new Chip(
                    avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('H')),
                    label: new Text('Mulligan'),
                  ),
                ],
              )
            ],
          ),

        ),

    );
  }

}