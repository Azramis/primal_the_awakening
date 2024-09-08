import 'dart:async';

FutureOr<R?> let<T, R>(
  FutureOr<T?> futureOrValue,
  FutureOr<R?> Function(T) action, [
  FutureOr<R?> Function()? ifNull,
]) async {
  final value = await futureOrValue;
  if (value != null) {
    return action(value);
  }

  return ifNull?.call();
}

R? letSync<T, R>(
  T? value,
  R? Function(T) action, [
  R? Function()? ifNull,
]) {
  if (value != null) {
    return action(value);
  }

  return ifNull?.call();
}

FutureOr<R> letSecure<T, R>(
  FutureOr<T?> futureOrValue,
  FutureOr<R> Function(T) action,
  FutureOr<R> Function() ifNull,
) async {
  final value = await futureOrValue;
  if (value != null) {
    return action(value);
  }

  return ifNull.call();
}

R letSecureSync<T, R>(
  T? value,
  R Function(T) action,
  R Function() ifNull,
) {
  if (value != null) {
    return action(value);
  }

  return ifNull.call();
}
