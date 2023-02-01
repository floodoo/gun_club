import 'package:gun_club/src/core/constants/supabase.constants.dart';
import 'package:gun_club/src/core/user/data/sources/dto/user.dto.dart';
import 'package:gun_club/src/core/user/data/sources/remote/user.api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user.controller.g.dart';

@Riverpod(keepAlive: true)
class UserController extends _$UserController {
  @override
  Future<UserDto> build() async {
    return ref.read(userApiProvider).getProfile(userId: supabase.auth.currentUser!.id);
  }
}
