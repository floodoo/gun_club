import 'package:gun_club/src/features/admin/data/sources/dto/user_profiles.dto.dart';
import 'package:gun_club/src/features/admin/data/sources/remote/admin.api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin.controller.g.dart';

@riverpod
class AdminController extends _$AdminController {
  @override
  Future<List<UserProfilesDto>> build() async {
    return ref.read(adminApiProvider).getUserProfiles();
  }
}
