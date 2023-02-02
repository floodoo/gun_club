import 'package:gun_club/src/core/constants/supabase.constants.dart';
import 'package:gun_club/src/features/profile/data/sources/remote/attendance.api.dart';
import 'package:gun_club/src/features/profile/domain/model/attendance.model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile.controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  @override
  Future<List<AttendanceModel>> build() async {
    return ref.read(attendanceApiProvider).getAttendances(userId: supabase.auth.currentUser!.id);
  }

  void reload() {
    state = const AsyncValue.loading();
    ref.invalidateSelf();
  }
}
