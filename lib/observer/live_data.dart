typedef Observer<T> = void Function(T t);

class LiveData<T> {
  var data;
  var mObservers = <Observer>[];

  LiveData(T data) {
    this.data = data;
  }

  void observer(Observer observer) {
    if (mObservers.contains(observer)) {
      return;
    }
    mObservers.add(observer);
  }

  void removeObserver(Observer observer) {
    mObservers.remove(observer);
  }

  void removeAll() {
    mObservers.clear();
  }

  void set(T value) {
    data = value;
    _dispatchingValue();
  }

  T get() {
    return data;
  }

  void add(Object item) {
    if (data != null && (data is List || data is Set)) {
      data.add(item);
      _dispatchingValue();
    }
  }

  void addAll(Object item) {
    if (data != null && (data is List || data is Set)) {
      data.addAll(item);
      _dispatchingValue();
    }
  }

  void remove(Object item) {
    if (data != null && (data is List || data is Set)) {
      data.remove(item);
      _dispatchingValue();
    }
  }

  void _dispatchingValue() {
    for (int i = 0; i < mObservers.length; i++) {
      mObservers[i].call(data);
    }
  }
}
