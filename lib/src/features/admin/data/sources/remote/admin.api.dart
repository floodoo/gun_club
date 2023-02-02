import 'dart:developer';

import 'package:gun_club/src/core/constants/supabase.constants.dart';
import 'package:gun_club/src/core/user/data/sources/dto/user.dto.dart';
import 'package:gun_club/src/features/admin/data/sources/dto/user_create.dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin.api.g.dart';

@riverpod
AdminApi adminApi(AdminApiRef ref) => AdminApi();

class AdminApi {
  Future<List<UserDto>> getUserProfiles() async {
    final response = await supabase.from('profiles').select().is_('mark_as_deleted', false);
    return (response as List<dynamic>).map((json) => UserDto.fromJson(json)).toList();
  }

  Future<void> attendUser({required String userId, required String departmentId}) async {
    await supabase.from('attendances').insert({"department_id": departmentId, "member_id": userId});
  }

  Future<void> updateUserType({required String userId, required int userTypeId}) async {
    await supabase.from('profiles').update({'usertype_id': userTypeId}).eq('member_id', userId);
  }

  Future<void> createUser({required UserCreateDto user}) async {
    final result = await supabase.from('auth.users').insert({}).select();

    log(result.toString());
  }

  Future<void> deleteUser({required String userId}) async {
    await supabase.from('profiles').update({'mark_as_deleted': true}).eq('member_id', userId);
  }
}
