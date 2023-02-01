import 'package:gun_club/src/core/constants/supabase.constants.dart';
import 'package:gun_club/src/features/gun_license/data/sources/dto/gun_license.dto.dart';

class GunLicenseApi {
  Future<GunLicenseDto> getGunLicense({required String userId}) async {
    final response = await supabase.from('profiles').select('gun_license').eq('user_id', userId).single();
    return GunLicenseDto.fromJson(response);
  }
}
