import 'dart:async';

Future<void> waitForState<T>({
  required Stream<T> stream,
  required bool Function(T state) condition,
}) async {
  final completer = Completer<void>();

  final subscription = stream.listen((state) {
    if (condition(state) && !completer.isCompleted) {
      completer.complete();
    }
  });

  await completer.future;
  await subscription.cancel();
}
