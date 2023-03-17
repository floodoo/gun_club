import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.dto.freezed.dart';
part 'user.dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required String memberId,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? email,
    @Default(false) bool gunLicense,
    required DateTime registeredSince,
    required int usertypeId,
    @Default(false) bool markAsDeleted,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
}
