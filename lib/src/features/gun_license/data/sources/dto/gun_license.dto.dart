import 'package:freezed_annotation/freezed_annotation.dart';

part 'gun_license.dto.freezed.dart';
part 'gun_license.dto.g.dart';

@freezed
class GunLicenseDto with _$GunLicenseDto {
  const factory GunLicenseDto({
    @Default(false) bool gunLicense,
  }) = _LicenseDto;

  factory GunLicenseDto.fromJson(Map<String, dynamic> json) => _$GunLicenseDtoFromJson(json);
}
