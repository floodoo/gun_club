import "package:freezed_annotation/freezed_annotation.dart";

part "user.model.freezed.dart";

@freezed
class User with _$User {
  const factory User({
    String? uuid,
    String? model,
    required String platform,
  }) = _User;
}
