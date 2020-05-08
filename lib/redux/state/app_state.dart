import 'package:meta/meta.dart';
import 'package:flutterstudy/redux/action/add_action.dart';

@immutable
class AppState {
  AddInfoState addInfoState;
  AppState({this.addInfoState});
  AppState.initState() : addInfoState = new AddInfoState();
}

class AddInfoState{
  int num;
  AddInfoState copyNew(int num){
    AddInfoState addInfoState = new AddInfoState();
    addInfoState.num = num;
    return addInfoState;
  }
}
