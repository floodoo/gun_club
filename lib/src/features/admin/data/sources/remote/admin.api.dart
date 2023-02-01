import 'package:gun_club/src/core/constants/supabase.constants.dart';
import 'package:gun_club/src/features/admin/data/sources/dto/user_profiles.dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin.api.g.dart';

@riverpod
AdminApi adminApi(AdminApiRef ref) => AdminApi();

class AdminApi {
  Future<List<UserProfilesDto>> getUserProfiles() async {
    final response = await supabase.from('profiles').select();
    return (response as List<dynamic>).map((json) => UserProfilesDto.fromJson(json)).toList();
  }
}