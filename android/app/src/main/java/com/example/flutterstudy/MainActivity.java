package com.example.flutterstudy;

import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    MethodChannel mMainChannel;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // 创建 Flutter 的 View 并绑定到 Activity
        Log.d("MainActivity", "onCreate: start");
        new MethodChannelHello(getFlutterEngine().getDartExecutor().getBinaryMessenger(), this.getApplicationContext());
    }
}