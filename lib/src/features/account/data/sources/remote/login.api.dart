import 'package:gun_club/src/core/constants/supabase.constants.dart';
import 'package:gun_club/src/features/account/data/sources/dto/user_update.dto.dart';
import 'package:gun_club/src/features/admin/data/sources/dto/user_create.dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login.api.g.dart';

@riverpod
LoginApi loginApi(LoginApiRef ref) => LoginApi();

class LoginApi {
  Future<void> createUserProfile({required UserCreateDto user}) async {
    final id = await supabase.rpc('get_latest_user_id').single();
    final userRequest = user.copyWith(memberId: id);
    await supabase.from('profiles').insert(userRequest);
  }

  Future<void> updateUserProfile({required UserUpdateDto user}) async {
    await supabase.from('profiles').update(user.toJson()).eq('member_id', supabase.auth.currentUser!.id);
  }
}
