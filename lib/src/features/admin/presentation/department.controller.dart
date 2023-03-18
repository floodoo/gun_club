import 'package:gun_club/src/features/admin/data/sources/dto/department.dto.dart';
import 'package:gun_club/src/features/admin/data/sources/remote/department.api.dart';
import 'package:gun_club/src/features/admin/presentation/admin.controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'department.controller.g.dart';

@riverpod
class DepartmentController extends _$DepartmentController {
  @override
  Future<List<DepartmentDto>> build() async {
    final List<DepartmentDto> departments = await ref.read(departmentApiProvider).getDepartments();
    return departments;
  }

  Future<void> updateUserDepartment({required String userId, required String departmentId}) async {
    await ref.read(departmentApiProvider).updateUserDepartment(userId: userId, departmentId: departmentId);
    ref.read(adminControllerProvider.notifier).reload();
  }

  void reload() {
    state = const AsyncValue.loading();
    ref.invalidateSelf();
  }
}
