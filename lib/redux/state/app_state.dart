import 'package:meta/meta.dart';
import 'package:flutterstudy/redux/action/add_action.dart';

@immutable
class AppState {
  AddInfoState addInfoState;
  ShangJiPageState shangJiPageState;
  AppState({this.addInfoState, this.shangJiPageState});
  AppState.initState(){
    addInfoState = new AddInfoState();
    shangJiPageState = new ShangJiPageState();
  }
}

class AddInfoState{
  int num;
  AddInfoState copyNew(int num){
    AddInfoState addInfoState = new AddInfoState();
    addInfoState.num = num;
    return addInfoState;
  }
}

class ShangJiPageState{
  int data;
  ShangJiPageState copyNew(int num){
    ShangJiPageState shangJiPageState = new ShangJiPageState();
    shangJiPageState.data = num;
    return shangJiPageState;
  }
}
