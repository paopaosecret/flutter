import 'package:redux/redux.dart';

import 'transform_page_state.dart';
import 'transform_page_action.dart';

final TransformPageReduceReducer = combineReducers<TransformPageState>([
  TypedReducer<TransformPageState, InitPageAction>(_reduceInitPage),
]);

TransformPageState _reduceInitPage(TransformPageState state, InitPageAction action){
  return TransformPageState.copy(state);
}