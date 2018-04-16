import 'dart:async';

class CompositeSubscription {
  static Set<StreamSubscription> _subscriptions = new Set();

  static void cancel() {
    for (var n in _subscriptions) {
      n.cancel();
    }
    _subscriptions = new Set();
  }

  static void add(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }

  static void addAll(Iterable<StreamSubscription> subs) {
    _subscriptions.addAll(subs);
  }

  bool remove(StreamSubscription subscription) {
    return _subscriptions.remove(subscription);
  }

  bool contains(StreamSubscription subscription) {
    return _subscriptions.contains(subscription);
  }

  List<StreamSubscription> toList() {
    return _subscriptions.toList();
  }
}