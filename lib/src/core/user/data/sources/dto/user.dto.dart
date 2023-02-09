import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.dto.freezed.dart';
part 'user.dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required String memberId,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    String? email,
    @Default(false) bool gunLicense,
    required DateTime registeredSince,
    required int usertypeId,
    String? addressId,
    @Default(false) bool markAsDeleted,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
}
