import 'package:gun_club/src/features/admin/data/sources/dto/user_profiles.dto.dart';
import 'package:gun_club/src/features/admin/data/sources/remote/admin.api.dart';
import 'package:gun_club/src/features/profile/presentation/profile.controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin.controller.g.dart';

@riverpod
class AdminController extends _$AdminController {
  @override
  Future<List<UserProfilesDto>> build() async {
    return ref.read(adminApiProvider).getUserProfiles();
  }

  Future<void> updateUserType({required String userId, required int userTypeId}) async {
    await ref.read(adminApiProvider).updateUserType(userId: userId, userTypeId: userTypeId);
    reload();
  }

  Future<void> attendUser({required String userId, required String departmentId}) async {
    await ref.read(adminApiProvider).attendUser(userId: userId, departmentId: departmentId);
    ref.read(profileControllerProvider.notifier).reload();
  }

  void reload() {
    state = const AsyncValue.loading();
    ref.invalidateSelf();
  }
}
