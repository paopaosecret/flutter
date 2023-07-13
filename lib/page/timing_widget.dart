import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class TimingWidget extends StatelessWidget {
  static StreamController<int> _streamController = StreamController<int>();

  static int count = 0;
  static late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<int>(
            stream: _streamController.stream,
            initialData: 0,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Text(
                snapshot.data == 0 ? "获取验证码" : '${snapshot.data} 秒后重发',
                style: (snapshot.data == 0)
                    ? TextStyle(color: Colors.white, fontSize: 14)
                    : TextStyle(color: Colors.grey, fontSize: 14),
              );
            }));
  }

  static void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (count >= 100) {
        stopTimer();
        return;
      }
      count++;
      int minute = count~/60;
      int second = count%60;
      print(sprintf('%02d:%02d', [minute, second]));
      _streamController.sink.add(count);
    });
  }

  static void stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
