package com.example.flutterstudy;

import android.content.Context;
import android.util.Log;
import android.widget.ImageView;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.example.flutterstudy.floatwindow.FloatWindowService;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MethodChannelHello implements MethodChannel.MethodCallHandler {
    private MethodChannel methodChannel;
    private BinaryMessenger binaryMessenger;
    private Context context;

    public MethodChannelHello(BinaryMessenger binaryMessenger, Context context) {
        this.context = context;
        this.binaryMessenger = binaryMessenger;
        methodChannel = new MethodChannel(binaryMessenger, "samples.flutter.io/battery");
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Log.d("MethodChannelHello", "method:" + call.method + ", arguments:" + call.arguments);
        if ("showToast".equals(call.method)) {
            showToast(call, result);
        } else if ("showFloat".equals(call.method)) {
            showFloat(call, result);
        } else if ("hideFloat".equals(call.method)) {
            hideFloat(call, result);
        }
    }

    private void hideFloat(MethodCall call, MethodChannel.Result result) {
        FloatWindowService.stopService(context);
    }

    private void showFloat(MethodCall call, MethodChannel.Result result) {
        int platformViewId = MethodCallUtils.getMethodParams(call, "platformViewId");
        Toast.makeText(context, "显示悬浮窗platformViewId:" + platformViewId, Toast.LENGTH_SHORT).show();

        FloatWindowService.startFloatService(context, new ImageView(context));
    }

    private void showToast(MethodCall call, MethodChannel.Result result) {
        String msg = MethodCallUtils.getMethodParams(call, "msg");
        Toast.makeText(context, msg, Toast.LENGTH_SHORT).show();
    }
}
