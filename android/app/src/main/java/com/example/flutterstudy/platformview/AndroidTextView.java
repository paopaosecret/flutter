package com.example.flutterstudy.platformview;

import android.content.Context;
import android.view.Gravity;
import android.view.View;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.example.flutterstudy.R;

import java.util.Map;

import io.flutter.Log;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.platform.PlatformView;

public class AndroidTextView implements PlatformView {
    private static final String TAG = "AndroidTextView";

    private Context mContext;
    private BinaryMessenger mBinaryMessenger;
    private int mId;
    private TextView mAndroidTextView;
    public Map mParams;

    public AndroidTextView(Context context, BinaryMessenger binaryMessenger, int id, Map params) {
        Log.d(TAG, "AndroidTextView 构造方法");
        mContext = context;
        mBinaryMessenger = binaryMessenger;
        mId = id;
        mParams = params;

        mAndroidTextView = new TextView(context);
        mAndroidTextView.setGravity(Gravity.CENTER);
        mAndroidTextView.setBackgroundColor(mContext.getResources().getColor(R.color.white));
        if(mParams != null) {
            mParams.containsKey("text");
            mAndroidTextView.setText((String)mParams.get("text"));
        }
    }

    @Nullable
    @Override
    public View getView() {
        Log.d(TAG, "AndroidTextView getView");
        return mAndroidTextView;
    }

    @Override
    public void onFlutterViewAttached(@NonNull View flutterView) {
        Log.d(TAG, "AndroidTextView onFlutterViewAttached");
        PlatformView.super.onFlutterViewAttached(flutterView);
    }

    @Override
    public void onFlutterViewDetached() {
        Log.d(TAG, "AndroidTextView onFlutterViewDetached");
        PlatformView.super.onFlutterViewDetached();
    }

    @Override
    public void dispose() {
        Log.d(TAG, "AndroidTextView dispose");
    }

    @Override
    public void onInputConnectionLocked() {
        Log.d(TAG, "AndroidTextView onInputConnectionLocked");
        PlatformView.super.onInputConnectionLocked();
    }

    @Override
    public void onInputConnectionUnlocked() {
        Log.d(TAG, "AndroidTextView onInputConnectionUnlocked");
        PlatformView.super.onInputConnectionUnlocked();
    }
}
