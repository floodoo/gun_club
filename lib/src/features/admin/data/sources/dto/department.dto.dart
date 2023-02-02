import 'package:freezed_annotation/freezed_annotation.dart';

part 'department.dto.freezed.dart';
part 'department.dto.g.dart';

@freezed
class DepartmentDto with _$DepartmentDto {
  const factory DepartmentDto({
    required String departmentId,
    required String name,
    required double price,
  }) = _UserProfilesDto;

  factory DepartmentDto.fromJson(Map<String, dynamic> json) => _$DepartmentDtoFromJson(json);
}
