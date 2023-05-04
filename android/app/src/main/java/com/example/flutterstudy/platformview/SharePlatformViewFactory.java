package com.example.flutterstudy.platformview;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.HashMap;
import java.util.Map;

import io.flutter.Log;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class SharePlatformViewFactory extends PlatformViewFactory {

    private BinaryMessenger mBinaryMessenger;
    private Context mContext;
    private Map<Integer, AndroidTextView> mViewMap = new HashMap<>();

    public SharePlatformViewFactory(MessageCodec<Object> createArgsCodec) {
        super(createArgsCodec);
    }

    public SharePlatformViewFactory(Context context, BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        mContext = context;
        this.mBinaryMessenger = messenger;
    }

    @NonNull
    @Override
    public PlatformView create(Context context, int viewId, @Nullable Object args) {
        Log.d("SharePlatformViewFactory-AndroidTextView", "create: viewId = " + viewId);
        Map map = null;
        if (args != null && args instanceof Map) {
            map = (Map) args;
        }
        AndroidTextView view = mViewMap.get(viewId);
        if (view == null) {
            view = new AndroidTextView(context, mBinaryMessenger, viewId, map);
            mViewMap.put(viewId, view);
        } else {
            view.mParams = map;
        }
        return view;
    }

    public void destroy(int viewId) {
        if (mViewMap.containsKey(viewId)) {
            mViewMap.remove(viewId);
        }
    }
}
