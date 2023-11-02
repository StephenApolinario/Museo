import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:museo/constants/routes.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/helpers/loading_complete.dart';
import 'package:museo/helpers/loading_screen.dart';
import 'package:museo/models/user/logged_user.dart';
import 'package:museo/models/user/login_user.dart';
import 'package:museo/models/user/registering_user.dart';
import 'package:museo/models/user/update_password_user.dart';
import 'package:museo/models/user/updating_user.dart';
import 'dart:convert';

import 'package:museo/providers/register/registerig_fields.dart';
import 'package:museo/providers/update/updating_fields.dart';
import 'package:museo/providers/user/user.dart';
import 'package:museo/services/endpoints.dart';
import 'package:provider/provider.dart';

class UserService {
  Future create(
      {required BuildContext context, required String password}) async {
    final registeringFields =
        Provider.of<RegisteringFields>(context, listen: false);
    RegisteringUser user = RegisteringUser(
      name: registeringFields.registerUserInformation.personalData.name,
      lastName: registeringFields.registerUserInformation.personalData.lastName,
      email: registeringFields.registerUserInformation.personalData.email,
      cpf: registeringFields.registerUserInformation.personalData.cpf,
      birthday: DateFormat('dd/MM/yyyy').parse(
          registeringFields.registerUserInformation.personalData.birthday),
      phoneNumber:
          registeringFields.registerUserInformation.personalData.phoneNumber,
      cep: registeringFields.registerUserInformation.addressData.cep,
      state: registeringFields.registerUserInformation.addressData.state,
      city: registeringFields.registerUserInformation.addressData.city,
      neighborhood:
          registeringFields.registerUserInformation.addressData.neighborhood,
      address: registeringFields.registerUserInformation.addressData.address,
      number: registeringFields.registerUserInformation.addressData.number,
      complement:
          registeringFields.registerUserInformation.addressData.complement,
      password: password,
      picture:
          'https://www.nopicture.com.br/', //TODO: In future, when user can upload the image, you must change this line code
    );

    LoadingScreen().show(
      context: context,
      title: context.loc.loading,
      subtitle: context.loc.wait_a_second,
    );
    final response =
        await http.post(Api().user(endpoint: '/'), body: user.toJson());

    if (response.statusCode != 201) {
      if (context.mounted) {
        final duplicatedEmail = (jsonDecode(response.body)['error'] ==
            'Failed! Email is already in use');
        await loadingMessageTime(
          title: context.loc.dialog_error_ops,
          subtitle: duplicatedEmail
              ? context.loc.duplicated_email
              : jsonDecode(response.body)['error'].toString(),
          context: context,
        );
      }
    } else {
      if (context.mounted) {
        loadingMessageTime(
          title: context.loc.successful,
          subtitle: context.loc.successful_registred_user,
          context: context,
        ).then((_) {
          registeringFields.clear();
          Navigator.of(context).pop();
        });
      }
    }
  }

  Future login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    final navigator = Navigator.of(context);
    final userProvider = Provider.of<User>(context, listen: false);

    final UserLogin user = UserLogin(
      email: email,
      password: password,
    );

    final response = await http.post(
      Api().user(endpoint: '/login'),
      body: user.toJson(),
    );

    final body = jsonDecode(response.body);

    if (response.statusCode != 200) {
      if (context.mounted) {
        await loadingMessageTime(
          title: context.loc.dialog_error_ops,
          subtitle: context.loc.login_error,
          context: context,
        );
      }
    } else {
      userProvider.updateLoggedUser(
        token: body['token'].toString(),
        user: LoggedUser.fromJson(body['user']),
      );

      if (context.mounted) {
        await loadingMessageTime(
          title: context.loc.successful,
          subtitle: context.loc.successful_login_user,
          context: context,
        );
        navigator.pushNamed(home);
      }
    }
  }

  logout(BuildContext context) async {
    final navigator = Navigator.of(context);
    final userProvider = Provider.of<User>(context, listen: false);
    userProvider.logOut();

    await loadingMessageTime(
      title: context.loc.leaving,
      subtitle: context.loc.redirecting,
      context: context,
    );
    navigator.pop();
  }

  Future updatePasword({
    required BuildContext context,
    required String actualPassword,
    required String newPassword,
  }) async {
    final navigator = Navigator.of(context);

    final response = await http.post(
      Api().user(endpoint: '/updatePassword'),
      headers: userJwt(context),
      body: UserUpdatePassword(
        actualPassword: actualPassword,
        newPassword: newPassword,
      ).toJson(),
    );

    bool error = response.statusCode != 200;

    if (context.mounted) {
      await loadingMessageTime(
        title: error
            ? context.loc.error_button_update
            : context.loc.success_button_update,
        subtitle: error
            ? context.loc.update_password_error
            : context.loc.update_password_success,
        context: context,
      );
      if (!error) {
        navigator.pop();
      }
    }
  }

  Future updateInformation({
    required BuildContext context,
  }) async {
    final navigator = Navigator.of(context);
    final updatingField = Provider.of<UpdatingFields>(context, listen: false);
    UpdatingUser updateUser = UpdatingUser(
      name: updatingField.updateUserInformation.personalData.name,
      lastName: updatingField.updateUserInformation.personalData.lastName,
      email: updatingField.updateUserInformation.personalData.email,
      cpf: updatingField.updateUserInformation.personalData.cpf,
      birthday: DateFormat('dd/MM/yyyy')
          .parse(updatingField.updateUserInformation.personalData.birthday),
      phoneNumber: updatingField.updateUserInformation.personalData.phoneNumber,
      cep: updatingField.updateUserInformation.addressData.cep,
      state: updatingField.updateUserInformation.addressData.state,
      city: updatingField.updateUserInformation.addressData.city,
      neighborhood:
          updatingField.updateUserInformation.addressData.neighborhood,
      address: updatingField.updateUserInformation.addressData.address,
      number: updatingField.updateUserInformation.addressData.number,
      complement: updatingField.updateUserInformation.addressData.complement,
      picture:
          'https://www.nopicture.com.br/', //TODO: In future, when user can upload the image, you must change this line code
    );

    final response = await http.patch(
      Api().user(endpoint: 'update'),
      headers: userJwt(context),
      body: updateUser.toJson(),
    );

    bool error = response.statusCode != 200;

    if (context.mounted) {
      await loadingMessageTime(
        title: error
            ? context.loc.error_button_update
            : context.loc.success_button_update,
        subtitle: error
            ? context.loc.update_data_error
            : context.loc.update_data_success,
        context: context,
      );
    }
    if (context.mounted) {
      if (!error) {
        await updateInformationUser(context);
        navigator.pop();
      }
    }
  }

  Future updateInformationUser(BuildContext context) async {
    final userProvider = Provider.of<User>(context, listen: false);

    final response = await http.post(
      Api().user(endpoint: 'login'),
      headers: userJwt(context),
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (context.mounted) {
        userProvider.updateLoggedUser(
          token: body['token'].toString(),
          user: LoggedUser.fromJson(body['user']),
        );
      }
    }
  }

  Future<String> addFavorite(BuildContext context, String museumPieceID) async {
    final favoriteID = {
      'favoriteID': museumPieceID,
    };

    final response = await http.post(Api().user(endpoint: 'favorite/add'),
        headers: userJwt(context), body: favoriteID);

    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (context.mounted) {
        await updateInformationUser(context);
        return 'sucess';
      }
    }

    if (jsonResponse['error'] ==
        'User already have favorited this museum piece!') {
      return 'user-already-have-favorite';
    }

    return 'error';
  }

  Future removeFavorite(BuildContext context, String museumPieceID) async {
    final navigator = Navigator.of(context);

    final favoriteID = {
      'favoriteID': museumPieceID,
    };

    final response = await http.post(
      Api().user(endpoint: 'favorite/remove'),
      headers: userJwt(context),
      body: favoriteID,
    );

    if (response.statusCode == 200) {
      if (context.mounted) {
        await updateInformationUser(context);
        navigator.pop();
      }
    }
  }

  bool checkQuiz(BuildContext context, String quizID) {
    final userProvider = Provider.of<User>(context, listen: false);

    final alreadyCompleted = userProvider.loggedUser.emblems
        .any((element) => element['quiz'] == quizID);

    return alreadyCompleted;
  }

  getEmblemFromQuiz(BuildContext context, String quizID) {
    final userProvider = Provider.of<User>(context, listen: false);

    final emblem = userProvider.loggedUser.emblems
        .firstWhere((emblem) => emblem['quiz'] == quizID);

    return emblem;
  }

  Future<String> sendResetPasswordLink(
      BuildContext context, String email) async {
    final response = await http.post(
      Api().user(endpoint: 'resetPassword/send'),
      body: {
        'email': email,
      },
    );

    if (response.statusCode != 200) {
      return 'error';
    }

    return 'success';
  }

  Future<String> resetPassword(
      BuildContext context, String code, String password) async {
    final response = await http.post(
      Api().user(endpoint: 'resetPassword'),
      body: {
        'code': code,
        'password': password,
      },
    );

    if (response.statusCode != 200) {
      return 'error';
    }

    return 'success';
  }
}

userJwt(BuildContext context) {
  final userProvider = Provider.of<User>(context, listen: false);

  return <String, String>{
    'Authorization': 'Bearer ${userProvider.authCode}',
  };
}
