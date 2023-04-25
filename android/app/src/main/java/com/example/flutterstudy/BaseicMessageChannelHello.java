package com.example.flutterstudy;

import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryCodec;
import io.flutter.plugin.common.BinaryMessenger;

public class BaseicMessageChannelHello implements BasicMessageChannel.MessageHandler {
    private BasicMessageChannel methodChannel;
    private BinaryMessenger     binaryMessenger;
    private Context             context;

    public BaseicMessageChannelHello(BinaryMessenger binaryMessenger, Context context) {
        this.context = context;
        this.binaryMessenger = binaryMessenger;
        methodChannel = new BasicMessageChannel(binaryMessenger, "samples.flutter.io", BinaryCodec.INSTANCE);
        methodChannel.setMessageHandler(this);
    }

    @Override
    public void onMessage(@Nullable Object message, @NonNull BasicMessageChannel.Reply reply) {
        Log.d("MessageChannelTest", "in android Received message = $message");
        reply.reply("Reply from Android");
    }
}
