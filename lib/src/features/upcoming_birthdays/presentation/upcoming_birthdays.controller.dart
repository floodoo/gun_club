import 'package:gun_club/src/features/upcoming_birthdays/data/sources/dto/birthday_user.dto.dart';
import 'package:gun_club/src/features/upcoming_birthdays/data/sources/remote/birthday.api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'upcoming_birthdays.controller.g.dart';

@riverpod
class UpcomingBirthdaysController extends _$UpcomingBirthdaysController {
  @override
  Future<List<BirthdayUserDto>> build() async {
    return ref.read(birthdayApiProvider).getUpcomingBirthdays();
  }
}
