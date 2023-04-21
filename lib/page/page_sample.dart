import 'package:flutter/material.dart';
import 'package:flutterstudy/eventbus/event_bus.dart';
import 'package:flutterstudy/eventbus/event_constant.dart';
import 'package:flutterstudy/widget/title_bar.dart';
import 'package:flutterstudy/widget/toast.dart';

class SimplePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SimpleState();
  }
}

class _SimpleState extends State<SimplePage> {

  @override
  Widget build(BuildContext context) {
    bus.register(EventAction.TEST_EVENT, (arg){
      ToastUtils.showToast(arg);
    });
    return  Scaffold(
            appBar: TitleBar().titleBar(context, '意见反馈',
                rightText: "提交",
                onRightPressed: (){

                  ToastUtils.showToast("提交成功: \n${_describleController.text} \n${_contractController.text}");
                }
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: <Widget>[
                  Container(
                    width: 360,
                    height: 46,
                    padding: EdgeInsets.all(10),
                    color: Color(0xF2F2F2F2),
                    child: Text(
                      '内容描述',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16
                      ),
                    ),
                  ),
                  Container(
                    width: 360,
                    height: 180,
                    padding: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 5),
                    child: TextFormField(
                      controller: _describleController,
                      enabled: true,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: '请填写您的宝贵意见,谢谢！',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: 360,
                    height: 46,
                    padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                    color: Color(0xF2F2F2F2),
                    child: Text(
                      '联系方式（选填）',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16
                      ),
                    ),
                  ),
                  Container(
                    width: 360,
                    height: 46,
                    padding: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
                    child: TextFormField(
                      controller: _contractController,
                      enabled: true,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: '请填写有效的联系方式',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: 360,
                    height: 312,
                    color: Color(0xF2F2F2F2),
                  ),
                ],
              ),
            ),
          );
  }

  TextEditingController _describleController = new TextEditingController();
  TextEditingController _contractController = new TextEditingController();
}
