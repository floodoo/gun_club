import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance.model.freezed.dart';
part 'attendance.model.g.dart';

@freezed
class AttendanceModel with _$AttendanceModel {
  const factory AttendanceModel({
    required String attendanceId,
    required String departmentId,
    required String memberId,
    required DateTime timestamp,
    required Department department,
  }) = _AttendanceModel;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) => _$AttendanceModelFromJson(json);
}

@freezed
class Department with _$Department {
  const factory Department({
    required String name,
  }) = _Department;

  factory Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);
}
