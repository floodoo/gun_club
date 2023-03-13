import 'package:gun_club/src/core/constants/supabase.constants.dart';
import 'package:gun_club/src/features/upcoming_birthdays/data/sources/dto/birthday_user.dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'birthday.api.g.dart';

@riverpod
BirthdayApi birthdayApi(BirthdayApiRef ref) => BirthdayApi();

class BirthdayApi {
  Future<List<BirthdayUserDto>> getUpcomingBirthdays() async {
    List<dynamic> response = await supabase.from("upcoming_birthdays").select();
    return response.map((json) => BirthdayUserDto.fromJson(json)).toList();
  }
}
