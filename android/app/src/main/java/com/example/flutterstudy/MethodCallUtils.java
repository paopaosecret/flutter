package com.example.flutterstudy;

import io.flutter.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MethodCallUtils {
    private static final String TAG = "TUICallKitFlutter";

    /**
     * 通用方法，获得参数值，如未找到参数，则直接中断
     */
    public static <T> T getMethodRequiredParams(MethodCall methodCall, String param, MethodChannel.Result result) {
        T parameter = methodCall.argument(param);
        if (parameter == null) {
            result.error("Missing parameter",
                    "Cannot find parameter `" + param + "` or `" + param + "` is null!",
                    -1001);
            Log.e(TAG, "|method=" + methodCall.method + "|arguments=null");
        }
        return parameter;
    }

    /**
     * 通用方法，获得参数值，参数可以为null
     */
    public static <T> T getMethodParams(MethodCall methodCall, String param) {
        T parameter = methodCall.argument(param);
        return parameter;
    }
}
