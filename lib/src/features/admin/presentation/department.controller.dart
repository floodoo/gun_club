import 'package:gun_club/src/features/admin/data/sources/dto/department.dto.dart';
import 'package:gun_club/src/features/admin/data/sources/remote/department.api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'department.controller.g.dart';

@riverpod
class DepartmentController extends _$DepartmentController {
  @override
  Future<List<DepartmentDto>> build() async {
    final List<DepartmentDto> departments = await ref.read(departmentApiProvider).getDepartments();
    if (departments.isEmpty) return [];
    departments.removeWhere((item) => item.departmentId == '827759fe-f85d-425f-b85e-044befceaca7');
    return departments;
  }

  void reload() {
    state = const AsyncValue.loading();
    ref.invalidateSelf();
  }
}
