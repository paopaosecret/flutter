import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterstudy/page/fragment_me.dart';
import 'package:flutterstudy/page/page_sample.dart';
import 'package:flutterstudy/page/redux_page.dart';
import 'package:flutterstudy/redux/app_reducer.dart';
import 'package:flutterstudy/redux/middleware/add_middleware.dart';
import 'package:flutterstudy/redux/reducer/app_reducer.dart';
import 'package:flutterstudy/redux/state/app_state.dart';
import 'package:flutterstudy/page/page_ui_test.dart';
import 'package:flutterstudy/widget/title_bar.dart';
import 'package:flutterstudy/widget/toast.dart';
import 'package:redux/redux.dart';

import 'page/my_store.dart';
import 'page/new_page.dart';
import 'package:flutterstudy/eventbus/event_bus.dart';
import 'package:flutterstudy/eventbus/event_constant.dart';

TextEditingController _describleController = new TextEditingController();
TextEditingController _contractController = new TextEditingController();
//bool get isInDebugMode {
//  bool inDebugMode = false;
//  assert(inDebugMode = true);
//  return inDebugMode;
//}
void main(){

  //注册Flutter框架的异常回调
  FlutterError.onError = (FlutterErrorDetails details) async {
    print("  FlutterError.onError: ${details.exception}");
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  runZoned((){
    final Store<AppState> _store = Store<AppState>(
      reducer,
      initialState: AppState.initState(),
      middleware: [AddMiddleware()],
    );
    runApp(MyApp(store: _store));
  }, onError: (error, stackTrace) async {
    //异常处理
    print("this is error ---$error");
  });

}

class MyApp extends StatefulWidget {
  String str;
  final Store<AppState> store;
  MyApp({this.store});
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<ItemBean> storeList = new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


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
          "problem_back":  (ctx) => new SimplePage(),
        },
        home: Builder(
          builder: (context) => Scaffold(
            appBar: TitleBar().titleBar(context, '测试列表页',),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                    onTap: (){
                      Future.delayed(Duration(seconds: 1))
                          .then((e) => throw StateError('This is a Dart exception 异步.'));
                    },
                    child: Container(
                        width: 100,
                        height: 50,
                        color: Color(0xFFF2F2F2),
                        child: Text("测试异步"))),
                GestureDetector(
                    onTap: (){
                      throw StateError('This is a Dart exception 同步');
                    },
                    child: Container(
                        width: 100,
                        height: 50,
                        color: Color(0xFFF2F2F2),
                        child: Text("测试同步"))),
                buildItem(context, "我的实体店", "my_store", null),
                buildItem(context, "福利商城", "fragment_me", null),
                buildItem(context, "UI测试页面", "ui_test", null),
                buildItem(context, "reduxPage", "redux_page", null),
                buildItem(context, "布局测试", "new_page", "布局测试页面参数"),
                buildItem(context, "问题反馈页面", "problem_back", null),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildItem(BuildContext context, String name, String jumpStr,  Object params,){
  return GestureDetector(
    onTap: (){
      if(params != null){
        Navigator.of(context).pushNamed(jumpStr, arguments: params);
      }else{
        Navigator.of(context).pushNamed(jumpStr);
      }

    },
    child: Container(
      margin: EdgeInsets.only(top: 5),
      width: 360,
      height: 46,
      padding: EdgeInsets.all(10),
      color: Color(0xFFEEEEEE),
      child: Text(
        name,
        style: TextStyle(
            color: Colors.black87,
            fontSize: 16
        ),
      ),
    ),
  );
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