import "package:freezed_annotation/freezed_annotation.dart";

part "app.exception.freezed.dart";

@freezed
class AppException with _$AppException {
  const factory AppException({
    required String message,
    int? code,
    Exception? exception,
  }) = _AppException;
}
