import 'package:gun_club/src/core/constants/supabase.constants.dart';
import 'package:gun_club/src/features/admin/data/sources/dto/department.dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'department.api.g.dart';

@riverpod
DepartmentApi departmentApi(DepartmentApiRef ref) => DepartmentApi();

class DepartmentApi {
  Future<List<DepartmentDto>> getDepartments() async {
    final response = await supabase.from('department').select();
    return (response as List<dynamic>).map((json) => DepartmentDto.fromJson(json)).toList();
  }
}
