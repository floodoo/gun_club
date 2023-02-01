import 'package:gun_club/src/core/constants/supabase.constants.dart';
import 'package:gun_club/src/features/profile/data/sources/dto/profile.dto.dart';

class ProfileApi {
  Future<ProfileDto> getProfile({required String userId}) async {
    final response = await supabase.from('profiles').select().eq('user_id', userId).single();
    return ProfileDto.fromJson(response);
  }
}
