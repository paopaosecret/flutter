
import 'package:flutter/services.dart';

const MethodChannel methodChannel = MethodChannel('samples.flutter.io/battery');
class MessageChannel{
  static Future<String> getBatteryLevel() async{
    try {
      final int result = await methodChannel.invokeMethod('getBatteryLevel');
      return "result:${result}";
    } on PlatformException {
      return "PlatformException";
    }
    return "show return null";
  }

  static Future<String> showToast(String msg) async{
    try {
      final int result = await methodChannel.invokeMethod('showToast', {"msg" : msg});
      return "result:${result}";
    } on PlatformException {
      return "PlatformException";
    }
    return "show return null";
  }


  static Future<String> showFloat(int platformViewId) async{
    try {
      final int result = await methodChannel.invokeMethod('showFloat', {"platformViewId" : platformViewId});
      return "result:${result}";
    } on PlatformException {
      return "PlatformException";
    }
  }

  static Future<String> hideFloat() async{
    try {
      final int result = await methodChannel.invokeMethod('hideFloat', {});
      return "result:${result}";
    } on PlatformException {
      return "PlatformException";
    }
    return "show return null";
  }
}