
import 'package:flutterstudy/channel/channel_platform.dart';

class FloatUtils{
  static void showFloat(int platformViewId){
    MessageChannel.showFloat(platformViewId);
  }

  static void hideFloat(){
    MessageChannel.hideFloat();
  }
}