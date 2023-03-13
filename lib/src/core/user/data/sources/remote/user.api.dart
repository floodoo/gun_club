import 'dart:developer';

import 'package:gun_club/src/core/constants/supabase.constants.dart';
import 'package:gun_club/src/core/user/data/sources/dto/user.dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user.api.g.dart';

@riverpod
UserApi userApi(UserApiRef ref) => UserApi();

class UserApi {
  Future<UserDto> getProfile({required String userId}) async {
    log('getProfile: $userId', name: 'UserApi');
    final response =
        await supabase.from('profiles').select().eq('member_id', userId).is_('mark_as_deleted', false).single();
    return UserDto.fromJson(response);
  }
}
