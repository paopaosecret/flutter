package com.example.flutterstudy;

import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import com.example.flutterstudy.platformview.SharePlatformViewFactory;

import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // 创建 Flutter 的 View 并绑定到 Activity
        Log.d("MainActivity", "onCreate: start");
        new MethodChannelHello(getFlutterEngine().getDartExecutor().getBinaryMessenger(), this.getApplicationContext());
        getFlutterEngine().getPlatformViewsController().getRegistry().registerViewFactory("platform_text_view",
                new SharePlatformViewFactory(this.getApplicationContext(), getFlutterEngine().getDartExecutor().getBinaryMessenger()));
    }
}