import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profiles.dto.freezed.dart';
part 'user_profiles.dto.g.dart';

@freezed
class UserProfilesDto with _$UserProfilesDto {
  const factory UserProfilesDto({
    required String memberId,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required String email,
    @Default(false) bool gunLicense,
    required DateTime registeredSince,
    required int usertypeId,
    required String addressId,
  }) = _UserProfilesDto;

  factory UserProfilesDto.fromJson(Map<String, dynamic> json) => _$UserProfilesDtoFromJson(json);
}
