import 'package:flutterstudy/redux/action/shangjia_action.dart';
import 'package:flutterstudy/redux/state/app_state.dart';
import 'package:redux/redux.dart';

//TODO 第三步：将处理后的数据转换为可用的状态数据
final shangJiReducer = combineReducers<ShangJiPageState>([
  TypedReducer<ShangJiPageState, ShangJiAction>(_shangJiOperator),
]);

ShangJiPageState _shangJiOperator(ShangJiPageState state, ShangJiAction action){
  return new ShangJiPageState().copyNew(action.increment);
}