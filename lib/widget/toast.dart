

import 'package:flutterstudy/channel/channel_platform.dart';

class ToastUtils{
  static void showToast(String msg){
    MessageChannel.showToast(msg);
  }
}