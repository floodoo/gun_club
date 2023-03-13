import 'package:gun_club/src/core/constants/supabase.constants.dart';
import 'package:gun_club/src/core/user/controller/user.controller.dart';
import 'package:gun_club/src/core/user/data/sources/remote/user.api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gun_license.controller.g.dart';

@riverpod
class GunLicenseController extends _$GunLicenseController {
  @override
  Future<void> build() async {}

  Future<bool> requestGunLicense({required bool currentLicense}) async {
    final result = await ref.read(userApiProvider).checkGunLicense(userId: supabase.auth.currentUser!.id);
    if (result != currentLicense) {
      await ref.read(userControllerProvider.notifier).reload();
      return true;
    }
    return false;
  }
}
