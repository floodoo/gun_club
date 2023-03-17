import 'package:gun_club/src/features/account/data/sources/dto/user_update.dto.dart';
import 'package:gun_club/src/features/account/data/sources/remote/login.api.dart';
import 'package:gun_club/src/features/admin/data/sources/dto/user_create.dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login.controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  Future<void> build() async {}

  Future<void> createUserProfile({required UserCreateDto user}) async {
    await ref.read(loginApiProvider).createUserProfile(user: user);
  }

  Future<void> updateUserProfile({
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
  }) async {
    await ref
        .read(loginApiProvider)
        .updateUserProfile(user: UserUpdateDto(firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth));
  }
}
