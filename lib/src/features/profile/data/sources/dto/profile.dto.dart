import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.dto.freezed.dart';
part 'profile.dto.g.dart';

@freezed
class ProfileDto with _$ProfileDto {
  const factory ProfileDto({
    required String userId,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required DateTime registeredSince,
    required String adressId,
    required String userTypeId,
  }) = _ProfileDto;

  factory ProfileDto.fromJson(Map<String, dynamic> json) => _$ProfileDtoFromJson(json);
}
