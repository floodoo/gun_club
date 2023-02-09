import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_create.dto.freezed.dart';
part 'user_create.dto.g.dart';

@freezed
class UserCreateDto with _$UserCreateDto {
  const factory UserCreateDto({
    String? memberId,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    String? email,
    @Default(false) bool gunLicense,
    required DateTime registeredSince,
    @Default(0) int usertypeId,
    @Default(false) bool markAsDeleted,
  }) = _UserCreateDto;

  factory UserCreateDto.fromJson(Map<String, dynamic> json) => _$UserCreateDtoFromJson(json);
}
