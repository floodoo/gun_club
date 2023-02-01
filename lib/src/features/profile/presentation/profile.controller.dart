import 'package:gun_club/src/core/constants/supabase.constants.dart';
import 'package:gun_club/src/features/profile/data/sources/dto/profile.dto.dart';
import 'package:gun_club/src/features/profile/data/sources/remote/profile.api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile.controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  @override
  Future<ProfileDto> build() async {
    return ProfileApi().getProfile(userId: supabase.auth.currentUser!.id);
  }
}
