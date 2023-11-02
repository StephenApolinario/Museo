import 'package:flutter/material.dart';
import 'package:museo/models/user/logged_user.dart';

class User with ChangeNotifier {
  late bool logged = false;
  late String? authCode;
  late LoggedUser loggedUser;

  void updateLoggedUser({
    required String token,
    required LoggedUser user,
  }) {
    loggedUser = user;
    authUser(jwt: token);
    logged = true;
    notifyListeners();
  }

  void logOut() {
    authCode = null;
    loggedUser.clearUserData();
    logged = false;
    notifyListeners();
  }

  void authUser({required String jwt}) {
    authCode = jwt;
  }
}
