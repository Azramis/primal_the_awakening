import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:primal_the_awakening/common/event_dispatcher.dart';

typedef ContextBridgeCallback<T> = FutureOr<T> Function(BuildContext context);

mixin class ContextBridge {
  final _dispatcher = EventDispatcherMixin<_ContextBridgeEvent>();

  FutureOr<T> bridge<T>(ContextBridgeCallback<T> callback) async {
    final event = _ContextBridgeEvent(callback);
    _dispatcher.dispatchEvent(event);

    return event._completer.future;
  }
}

mixin ContextBridgeStateMixin<SW extends StatefulWidget> on State<SW> {
  Iterable<ContextBridge> get bridges;

  @override
  void initState() {
    super.initState();

    for (final bridge in bridges) {
      bridge._dispatcher.addListener(_onContextBridge);
    }
  }

  @override
  void dispose() {
    for (final bridge in bridges) {
      bridge._dispatcher.removeListener(_onContextBridge);
    }
    super.dispose();
  }

  void _onContextBridge(_ContextBridgeEvent event) => event.resolve(context);
}

final class _ContextBridgeEvent<T> with Event {
  _ContextBridgeEvent(this._callback);

  final ContextBridgeCallback<T> _callback;
  final Completer<T> _completer = Completer<T>();

  void resolve(BuildContext context) {
    preventDefault();
    _completer.complete(_callback(context));
  }
}
