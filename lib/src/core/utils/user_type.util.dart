class UserType {
  static const UserType member = UserType._(0);
  static const UserType seniorAdmin = UserType._(1);
  static const UserType admin = UserType._(2);

  final int value;

  const UserType._(this.value);

  @override
  String toString() {
    switch (value) {
      case 0:
        return 'Mitglied';
      case 1:
        return 'Senior Admin';
      case 2:
        return 'Admin';
      default:
        return 'Mitglied';
    }
  }
}

class UserTypeUtil {
  static UserType getUserType(int userType) {
    switch (userType) {
      case 0:
        return UserType.member;
      case 1:
        return UserType.seniorAdmin;
      case 2:
        return UserType.admin;
      default:
        return UserType.member;
    }
  }
}
