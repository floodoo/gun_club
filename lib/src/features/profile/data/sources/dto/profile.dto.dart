import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.dto.freezed.dart';
part 'profile.dto.g.dart';

@freezed
class ProfileDto with _$ProfileDto {
  const factory ProfileDto({
    required String memberId,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required String email,
    @Default(false) bool gunLicense,
    required DateTime registeredSince,
    required int usertypeId,
    required String addressId,
  }) = _ProfileDto;

  factory ProfileDto.fromJson(Map<String, dynamic> json) => _$ProfileDtoFromJson(json);
}
