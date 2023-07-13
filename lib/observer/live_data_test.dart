import 'live_data.dart';

void main(){
  LiveData<bool> isMute = new LiveData(true);

  // 方式一
  // void Function(dynamic) isMuteChanged = (value) {
  //   print("isMute:{$value}");
  // };

  // 方式二
  void isMuteChanged(value) {
    print("isMute:{$value}");
  }

  // 方式三
  // Observer isMuteChanged = (value) {
  //   print("isMute:{$value}");
  // };

  isMute.observer(isMuteChanged);
  // isMute.observer((value) {
  //   print("isMute2:{$value}");
  // });
  isMute.set(false);
  isMute.set(true);
  isMute.removeObserver(isMuteChanged);
  isMute.set(false);


  LiveData<int> timeCount= new LiveData(10);
  // 方式四
  timeCount.observer((t) {
    print("timeCount:{$t}");
  });
  timeCount.set(11);
  timeCount.set(12);

  LiveData<String> groupId= new LiveData("");
  groupId.observer((t) {
    print("groupId:{$t}");
  });
  groupId.set("abc");
  groupId.set("def");

  LiveData<V2TXLiveMode> txLiveMode = new LiveData(V2TXLiveMode.v2TXLiveModeRTMP);
  txLiveMode.observer((t) {
    print("txLiveMode:{$t}");
  });
  txLiveMode.set(V2TXLiveMode.v2TXLiveModeRTC);
  txLiveMode.set(V2TXLiveMode.v2TXLiveModeRTMP);

  LiveData<User> user= new LiveData(User(1, "1"));
  print("user:${user.get()}");
  user.observer((t) {
    print("user:{$t}");
  });
  user.set(User(2, "2"));
  user.set(User(3, "3"));

  LiveData<List<User>> userList= new LiveData(<User>[]);
  userList.observer((t) {
    print("userList:{$t}");
  });
  userList.add(User(1, "2"));
  userList.add(User(2, "3"));
}

/// 支持协议
enum V2TXLiveMode {
  /// 支持协议: RTMP
  v2TXLiveModeRTMP,
  /// 支持协议: TRTC
  v2TXLiveModeRTC,
}

class User {
  int? id;
  String? name;

  User(int id, String name) {
    this.id = id;
    this.name = name;
  }

  @override
  String toString() {
    return "User:{id:${id},name:${name}}";
  }
}



