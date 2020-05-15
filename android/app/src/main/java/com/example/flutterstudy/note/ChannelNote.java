package com.example.flutterstudy.note;

/**
 * Platform:代表平台 例如 ios  android
 * Channel:代表通信的通道
 *
 * 使用Channel 和Platform可以在Flutter  和Native 之前通信
 *
 * Flutter中定义了三种不同的channel
 * BasicMessageChannel：用于传递字符串和半结构化的信息。双向传输数据有返回值
 * MethodChannel：用于传递方法调用（method invocation）。(Flutter 《-》Native)双向传递数据有返回值
 * EventChannel: 用于数据流（event streams）的通信。     (Native->Flutter)单向传递数据，没有返回值
 *
 * 三种Channel具有相同的下面三个属性：
 * name: String类型，代表Channel的名字，也是其唯一标识符。
 * messager：BinaryMessenger类型，代表消息信使，是消息的发送与接收的工具。
 * codec: MessageCodec类型或MethodCodec类型，代表消息的编解码器。
 *
 * Channel name:​ 一个Flutter应用中可能存在多个Channel，每个Channel在创建时必须指定一个独一无二的name，Channel之间使用name来区分彼此。
 * 当有消息从Flutter端发送到Platform端时，会根据其传递过来的channel name找到该Channel对应的Handler（消息处理器）。
 * BinaryMessenger:消息信使是Platform端与Flutter端通信的工具
 *
 * 理解流程：消息传递：从Flutter到Platform
 * public static void initMainMethod(BinaryMessenger messenger) {
 *     MethodChannel mMainChannel = new MethodChannel(messenger, methodChannel);
 *     mMainChannel.setMethodCallHandler((call, result) -> {});
 * }
 *
 *
 * 1.注册：当我们在Native端初始化一个Channel，并向该Channel注册处理消息的Handler时：
 * 实际上会生成一个BinaryMessageHandler 以Channel name为key注册到BinaryMessenger ，
 * 2.Flutter发送消息：Flutter端使用MethodChannel发送消息
 * const MethodChannel methodChannel = MethodChannel('penta.com:FlutterHybridArt')
 * String responseStr = await methodChannel.invokeMethod(method, paramsMap);
 *
 * 3.Native处理消息：当Flutter给Native发送消息时，BinaryMessager会根据传入的Channel name找到BinaryMessageHandler，并交给它处理注意：（参考下面代码的注释）
 * a、Binarymessenger在Android端是一个接口，其具体实现为FlutterNativeView。
 *      其在iOS端是一个协议，名称为FlutterBinaryMessenger，FlutterViewController遵循了它
 * ​ b、Binarymessenger并不知道Channel的存在，它只和BinaryMessageHandler打交道。而Channel和BinaryMessageHandler则是一一对应的。由于Channel从BinaryMessageHandler接收到的消息是二进制格式数据，无法直接使用，故Channel会将该二进制消息通过Codec（消息编解码器）解码为能识别的消息并传递给Handler进行处理。
 * MethodChannel.class
 * @UiThread
 * public void setMethodCallHandler(@Nullable MethodChannel.MethodCallHandler handler) {
 *     //使用BinaryMessageHandler 包装MethodCallHandler
 *     this.messenger.setMessageHandler(this.name, handler == null ? null : new MethodChannel.IncomingMethodCallHandler(handler));
 * }
 * private final class IncomingMethodCallHandler implements BinaryMessageHandler {
 *     private final MethodChannel.MethodCallHandler handler;
 *
 *     IncomingMethodCallHandler(MethodChannel.MethodCallHandler handler) {
 *         this.handler = handler;
 *     }
 *     //1、接收到BinaryMessenger 发送来的消息
 *     //2、先使用解码器解码
 *     //3、交给我们注册的MethodCallHandler处理
 *     @UiThread
 *     public void onMessage(ByteBuffer message, final BinaryReply reply) {
 *         MethodCall call = MethodChannel.this.codec.decodeMethodCall(message);
 *         try {
 *             this.handler.onMethodCall(call, new MethodChannel.Result() {
 *                 public void success(Object result) {
 *                     reply.reply(MethodChannel.this.codec.encodeSuccessEnvelope(result));
 *                 }
 *
 *                 public void error(String errorCode, String errorMessage, Object errorDetails) {
 *                     reply.reply(MethodChannel.this.codec.encodeErrorEnvelope(errorCode, errorMessage, errorDetails));
 *                 }
 *
 *                 public void notImplemented() {
 *                     reply.reply((ByteBuffer)null);
 *                 }
 *             });
 *         } catch (RuntimeException var5) {
 *             Log.e("MethodChannel#" + MethodChannel.this.name, "Failed to handle method call", var5);
 *             reply.reply(MethodChannel.this.codec.encodeErrorEnvelope("error", var5.getMessage(), (Object)null));
 *         }
 *
 *     }
 * }
 *
 *
 * ​ 	4、返回处理结果给Flutter：当Handler处理完消息之后，会通过回调函数返回result，并将result通过编解码器编码为二进制格式数据，通过BinaryMessenger发送回Flutter端。
 * mMainChannel.setMethodCallHandler((call, result) -> {
 *     switch (call.method) {//根据方法名进行处理
 *         case httpPostMethod:
 *             //返回处理结果
 *             result.success("Hello result");}}
 *
 *
 * 5:Flutter端接收处理结果：
 * try {
 *     //接收响应的结果
 *   String responseStr = await methodChannel.invokeMethod(method, paramsMap);
 * }
 */
public class ChannelNote {
}
