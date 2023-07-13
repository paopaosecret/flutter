import 'package:flutter/material.dart';
import 'package:flutterstudy/observer/live_data.dart';

import '../widget/toast.dart';

class FunctionWidget extends StatefulWidget {
  @override
  _FunctionWidgetState createState() => _FunctionWidgetState();
}

class _FunctionWidgetState extends State<FunctionWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child:
        // TUICallState.instanse.isMute? Image.asset("assets/images/icon_credit_setting.png", width:22, height:22) :
        Image.asset("assets/images/icon_credit_setting.png", width:22, height:22) ,
        onTap: (){
            // setState(() {
            //   // CallEngineManager.instanse.closeMicrophone();
            //   // TUICallState.instanse.isMute = true;
            // });
        },
      ),
    );
  }
}
