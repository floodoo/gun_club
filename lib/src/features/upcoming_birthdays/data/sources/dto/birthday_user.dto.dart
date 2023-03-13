import 'package:freezed_annotation/freezed_annotation.dart';

part 'birthday_user.dto.freezed.dart';
part 'birthday_user.dto.g.dart';

@freezed
class BirthdayUserDto with _$BirthdayUserDto {
  const factory BirthdayUserDto({
    required String memberId,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
  }) = _BirthdayUserDto;

  factory BirthdayUserDto.fromJson(Map<String, dynamic> json) => _$BirthdayUserDtoFromJson(json);
}
