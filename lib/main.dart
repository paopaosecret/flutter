import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterstudy/fragment_me.dart';
import 'package:flutterstudy/redux/middleware/add_middleware.dart';
import 'package:flutterstudy/redux/reducer/app_reducer.dart';
import 'package:flutterstudy/redux/state/app_state.dart';
import 'package:flutterstudy/ui_test.dart';
import 'package:flutterstudy/widget/title_bar.dart';
import 'package:flutterstudy/widget/toast.dart';
import 'package:redux/redux.dart';

import 'my_store.dart';
import 'new_page.dart';
import 'redux_page.dart';
import 'package:flutterstudy/eventbus/event_bus.dart';
import 'package:flutterstudy/eventbus/event_constant.dart';

TextEditingController _describleController = new TextEditingController();
TextEditingController _contractController = new TextEditingController();
void main(){

  final Store<AppState> _store = Store<AppState>(
    reducer,
    initialState: AppState.initState(),
    middleware: [AddMiddleware()],
  );
  runApp(MyApp(store: _store));
}

class MyApp extends StatefulWidget {
  String str;
  final Store<AppState> store;
  MyApp({this.store});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    bus.register(EventAction.TEST_EVENT, (arg){
      ToastUtils.showToast(arg);
    });
    return StoreProvider<AppState>(
        store: widget.store,
        child: MaterialApp(
          title: 'Flutte',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        //注册路由表
        routes: {
          "new_page": (context) => new NewPage(),
          "ui_test": (context) => new UITest(),
          "my_store": (context) => new MyStore(),
          "fragment_me": (context) => new FragmentMe(),
          "redux_page":  (ctx) => new ReduxPage(),
        },
        home: Builder(
          builder: (context) => Scaffold(
            appBar: TitleBar().titleBar(context, '意见反馈',
              rightText: "提交",
              onRightPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ReduxPage()));
                ToastUtils.showToast("提交成功");
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
          ),
        ),
      ),
    );
  }
}

void collectLog(String line){
  print("收集日志:" + line);
}
void reportErrorAndLog(FlutterErrorDetails details){
  print("上报错误和日志逻辑");
}

FlutterErrorDetails makeDetails(Object obj, StackTrace stack){
  print("构建错误信息");
}