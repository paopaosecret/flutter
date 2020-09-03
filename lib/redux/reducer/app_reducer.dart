import 'package:flutterstudy/redux/action/add_action.dart';
import 'package:flutterstudy/redux/state/app_state.dart';
import 'package:redux/redux.dart';


/**
 * reducer会根据传进来的action生成新的CountState
 * 定义Reducer<State>(State state, dynamic action);方法  名字为 State
 * 返回
 * typedef State Reducer<State>(State state, dynamic action);
 */

//TODO 第三步：将处理后的数据转换为可用的状态数据
final addInfoReducer = combineReducers<AddInfoState>([
  TypedReducer<AddInfoState, AddAction>(_addOperator),
]);

AddInfoState _addOperator(AddInfoState state, AddAction action){
  return new AddInfoState().copyNew(action.increment);
}