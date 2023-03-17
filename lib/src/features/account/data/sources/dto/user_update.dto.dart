import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_update.dto.freezed.dart';
part 'user_update.dto.g.dart';

@freezed
class UserUpdateDto with _$UserUpdateDto {
  const factory UserUpdateDto({
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
  }) = _UserUpdateDto;

  factory UserUpdateDto.fromJson(Map<String, dynamic> json) => _$UserUpdateDtoFromJson(json);
}
