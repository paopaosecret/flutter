//订阅者回调签名
typedef void EventCallback(arg);

class EventBus{
  //私有化构造函数
  EventBus._newObject();

  //保存单例
  static EventBus _singleton = new EventBus._newObject();

  //工厂构造函数
  factory EventBus() => _singleton;

  //保存全部事件的订阅消息队列
  var _messageQueue = new Map<Object, List<EventCallback>>();

  //添加订阅者
  void register(eventName, EventCallback callback){
    if(eventName != null && callback != null){
      //如果该事件的订阅消息队列为空，则初始化该事件消息队列
      if (_messageQueue[eventName] == null) {
        _messageQueue[eventName] =  <EventCallback>[];
      }
      //为该事件添加订阅回调
      _messageQueue[eventName]?.add(callback);
    }
  }

  //移除订阅者
  void unregister(eventName, EventCallback callback){
    if(eventName != null && callback != null){
      var list = _messageQueue[eventName];
      if(list != null){
        list.remove(callback);
      }
    }
  }

  //触发订阅事件的全部回调
  void notify(eventName, [arg]){
    var list= _messageQueue[eventName];
    if(list != null && list.length > 0){
      for(var i = 0; i< list.length; i++){
        list[i](arg);
      }

    }
  }
}

//定义一个全局变量，页面引入该文件可以直接使用bus
var bus = new EventBus();