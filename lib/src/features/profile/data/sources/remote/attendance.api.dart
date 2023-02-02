import 'package:gun_club/src/core/constants/supabase.constants.dart';
import 'package:gun_club/src/features/profile/domain/model/attendance.model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'attendance.api.g.dart';

@riverpod
AttendanceApi attendanceApi(AttendanceApiRef ref) => AttendanceApi();

class AttendanceApi {
  Future<List<AttendanceModel>> getAttendances({required String userId}) async {
    final response = await supabase
        .from('attendances')
        .select('*, department (name)')
        .eq("member_id", userId)
        .order('timestamp', ascending: true);

    return (response as List<dynamic>).map((json) => AttendanceModel.fromJson(json)).toList();
  }
}
