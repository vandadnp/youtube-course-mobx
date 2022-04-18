const oneSecond = Duration(seconds: 1);

extension WithDelay<T> on T {
  Future<T> toFuture([Duration? delay]) =>
      delay != null ? Future.delayed(delay, () => this) : Future.value(this);
}
