import 'package:mynewsapp/core/error/app_exception.dart';

/// Repositories return [Result] instead of throwing. Controllers never
/// write try/catch around transport — they just switch on this.
sealed class Result<T> {
  const Result();
}

class Ok<T> extends Result<T> {
  final T value;
  const Ok(this.value);
}

class Err<T> extends Result<T> {
  final AppException error;
  const Err(this.error);
}
