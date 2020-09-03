import 'package:flutterstudy/redux/action/shangjia_action.dart';
import 'package:redux/redux.dart';

//TODO 第二步接收到Action 处理数据
class ShangJiMiddleware extends MiddlewareClass{

  @override
  void call(Store store, action, next){
    // TODO: implement call
    if(action is ShangJiAction){         //
      if(action.increment < 0){
        action.increment = 0;
      }
    }
    next(action);
  }

}