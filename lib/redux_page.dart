import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterstudy/channel/channel_platform.dart';
import 'package:flutterstudy/redux/action/add_action.dart';
import 'package:flutterstudy/redux/state/app_state.dart';
import 'package:flutterstudy/eventbus/event_bus.dart';
import 'package:flutterstudy/eventbus/event_constant.dart';
import 'package:flutterstudy/widget/toast.dart';

class ReduxPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _State();
  }

}

class _State extends State<ReduxPage> {

  @override
  Widget build(BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(AddAction(0));  //第一步：发送一个时间到Redux
    return StoreConnector<AppState, AddInfoState>(
      distinct: true,
      converter: (store) => store.state.addInfoState,
      builder: (BuildContext context, AddInfoState addInfoState) {
        return Listener(
          child: Container(
            color: Colors.redAccent,
            child: Center(
              child: GestureDetector(
                onTap: (){
                  MessageChannel.getBatteryLevel().then((result){
                    print(result);
                  });
                },
                child: Text(
                  addInfoState.num.toString(),
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ),
          ),
//          onPointerDown: (PointerDownEvent event){
//            ToastUtils.showToast("按下屏幕: x = ${event.position.dx}, y = ${event.position.dy}");
//          },
//          onPointerMove: (PointerMoveEvent event){
//            if(event.position.dx.round() % 20 == 0){
//              ToastUtils.showToast("移动手指: x = ${event.position.dx}, y = ${event.position.dy}");
//            }
//          },
//          onPointerUp: (PointerUpEvent event){
//            bus.notify(EventAction.TEST_EVENT, "hello dart eventbus");
////            ToastUtils.showToast("抬起手指: x = ${event.position.dx}, y = ${event.position.dy}");
//          },
        );
      },
    );
  }
}