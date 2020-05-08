package com.example.flutterstudy;

import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import java.util.Map;

import io.flutter.app.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

////  @Override
////  public void configureFlutterEngine(FlutterEngine flutterEngine) {
////      GeneratedPluginRegistrant.registerWith(flutterEngine);
////  }


    @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    // 创建 Flutter 的 View 并绑定到 Activity
    Log.d("MainActivity", "onCreate: start");
    FlutterEngine flutterEngine = new FlutterEngine(this);
    GeneratedPluginRegistrant.registerWith(flutterEngine);

    new MethodChannel(getFlutterView(), "samples.flutter.io/battery").setMethodCallHandler(new MethodChannel.MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
            if("getBatteryLevel".equals(methodCall.method)){
                Toast.makeText(MainActivity.this, "获取电池电量成功", Toast.LENGTH_SHORT).show();
                result.success(10);
            }else if("showToast".equals(methodCall.method)){
                String msg = methodCall.argument("msg");
                Toast.makeText(MainActivity.this, msg, Toast.LENGTH_SHORT).show();
            }else{
                result.notImplemented();
            }
        }
    });
  }
}
