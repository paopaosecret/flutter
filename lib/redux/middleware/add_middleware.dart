
import 'package:flutterstudy/redux/action/add_action.dart';
import 'package:redux/redux.dart';

//TODO 第二步接收到Action 处理数据
class AddMiddleware extends MiddlewareClass{

  @override
  void call(Store store, action, next){
    // TODO: implement call
    if(action is AddAction){         //
      if(action.increment < 0){
        action.increment = 0;
      }
    }
    next(action);
  }

}