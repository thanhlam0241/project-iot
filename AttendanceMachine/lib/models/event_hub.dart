typedef EventCallback<T> = void Function(T arg);

class EventHub<T> {
  final List<EventCallback<T>> _callbacks = [];

  void addListener(EventCallback<T> callback) {
    _callbacks.add(callback);
  }

  void removeListener(EventCallback<T> callback) {
    _callbacks.remove(callback);
  }

  void emit(T arg) {
    for (final callback in _callbacks) {
      callback(arg);
    }
  }
}