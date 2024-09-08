import 'dart:async';

import 'package:meta/meta.dart';

typedef EventListener<E extends Event> = FutureOr<void> Function(E data);

mixin class Event {
  bool _isPrevented = false;

  @nonVirtual
  void preventDefault() => _isPrevented = true;
}

abstract interface class EventDispatcher<E extends Event> {
  void addListener(EventListener<E> listener);
  void removeListener(EventListener<E> listener);
  void dispatchEvent(E event);
}

mixin class EventDispatcherMixin<E extends Event> {
  final _listeners = <EventListener<E>>{};

  void addListener(EventListener<E> listener) {
    _listeners.add(listener);
  }

  void removeListener(EventListener<E> listener) {
    _listeners.remove(listener);
  }

  void dispatchEvent(E event) async {
    for (final listener in _listeners) {
      if (event._isPrevented) break; // Stop propagation
      await listener(event);
    }
  }
}
