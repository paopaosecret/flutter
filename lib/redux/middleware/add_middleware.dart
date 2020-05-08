
import 'package:flutterstudy/redux/action/add_action.dart';
import 'package:redux/redux.dart';

//第二步接收到Action 处理数据
class AddMiddleware extends MiddlewareClass{

  @override
  void call(Store store, action, next){
    // TODO: implement call
    if(action is AddAction){         //
      action.increment = 100;
    }
    next(action);
  }

}