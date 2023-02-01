import 'package:gun_club/src/core/constants/supabase.constants.dart';
import 'package:gun_club/src/features/gun_license/data/sources/dto/gun_license.dto.dart';
import 'package:gun_club/src/features/gun_license/data/sources/remote/gun_license.api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gun_license.controller.g.dart';

@riverpod
class GunLicenseController extends _$GunLicenseController {
  @override
  Future<GunLicenseDto> build() async {
    return GunLicenseApi().getGunLicense(userId: supabase.auth.currentUser!.id);
  }
}
