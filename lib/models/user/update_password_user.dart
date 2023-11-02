class UserUpdatePassword {
  final String actualPassword, newPassword;

  UserUpdatePassword({
    required this.actualPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'actualPassword': actualPassword,
      'newPassword': newPassword,
    };
  }
}
