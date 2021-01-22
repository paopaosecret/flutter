package com.example.flutterstudy;

import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // 创建 Flutter 的 View 并绑定到 Activity
        Log.d("MainActivity", "onCreate: start");
//    V.1.12.13hotfix版本初始， Flutter 1.17.1 时需要注掉
//    FlutterEngine flutterEngine = new FlutterEngine(this);
//    GeneratedPluginRegistrant.registerWith(flutterEngine);

//        new MethodChannel(getFlutterEngine(), "samples.flutter.io/battery").setMethodCallHandler(new MethodChannel.MethodCallHandler() {
//            @Override
//            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
//                if ("getBatteryLevel".equals(methodCall.method)) {
//                    Toast.makeText(MainActivity.this, "获取电池电量成功", Toast.LENGTH_SHORT).show();
//                    result.success(10);
//                } else if ("showToast".equals(methodCall.method)) {
//                    String msg = methodCall.argument("msg");
//                    Toast.makeText(MainActivity.this, msg, Toast.LENGTH_SHORT).show();
//                } else {
//                    result.notImplemented();
//                }
//            }
//        });
    }
}