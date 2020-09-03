import 'package:flutterstudy/redux/reducer/app_reducer.dart';
import 'package:flutterstudy/redux/reducer/shangji_reduce.dart';
import 'package:flutterstudy/redux/state/app_state.dart';

//TODO 页面级别Reducer注册
AppState reducer(AppState state, dynamic action){
    return new AppState(
        addInfoState: addInfoReducer(state.addInfoState, action),
        shangJiPageState: shangJiReducer(state.shangJiPageState, action)
    );
}