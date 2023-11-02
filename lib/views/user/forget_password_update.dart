import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/constants/routes.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/gen/assets.gen.dart';
import 'package:museo/helpers/loading_complete.dart';
import 'package:museo/services/user_service.dart';

class UserGetNewPassword extends StatefulWidget {
  const UserGetNewPassword({super.key});

  @override
  State<UserGetNewPassword> createState() => _UserGetNewPasswordState();
}

class _UserGetNewPasswordState extends State<UserGetNewPassword> {
  final formLoginKey = GlobalKey<FormState>();
  late String? code, password;

  final int minimumPasswordCharacters = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlue,
      appBar: AppBar(
        title: Text(
          context.loc.forgot_password,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: mainBlue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              imageOnTop(),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    updatePasswordTitle(context),
                    codeAndPasswordInputs(context),
                    sendButton(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Image imageOnTop() {
    return Image.asset(
      Assets.user.forgetPassword.path,
      height: 300,
    );
  }

  Widget sendButton(BuildContext context) {
    return Column(
      children: [
        // Enter
        const SizedBox(height: 20),
        TextButton(
          child: Text(
            context.loc.send,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          onPressed: () async {
            FocusManager.instance.primaryFocus?.unfocus();
            final isValid = formLoginKey.currentState!.validate();

            if (isValid) {
              formLoginKey.currentState!.save();
              final sendEmail =
                  await UserService().resetPassword(context, code!, password!);
              if (context.mounted) {
                loadingMessageTime(
                  title: sendEmail == 'error'
                      ? context.loc.dialog_error_ops
                      : context.loc.successful,
                  subtitle: sendEmail == 'error'
                      ? context.loc.update_password_from_code_failed
                      : context.loc.update_password_from_code_success,
                  context: context,
                );
                if (sendEmail == 'success') {
                  Navigator.of(context).pushReplacementNamed(login);
                }
              }
            }
          },
        ),
      ],
    );
  }

  Widget codeAndPasswordInputs(BuildContext context) {
    return Form(
      key: formLoginKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          codeInput(context),
          const SizedBox(
            height: 20,
          ),
          passwordInput(context),
        ],
      ),
    );
  }

  Widget codeInput(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            context.loc.password_code,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: context.loc.your_code_password_example,
            contentPadding: const EdgeInsets.only(left: 10),
            fillColor: Colors.white,
            filled: true,
            border: const OutlineInputBorder(),
            errorStyle: const TextStyle(
              color: Colors.red,
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value == '') {
              return context.loc.password_reset_blank_code;
            }
            return null;
          },
          onSaved: (newValue) => setState(() {
            code = newValue;
          }),
        ),
      ],
    );
  }

  Widget passwordInput(BuildContext context) {
    return Column(
      children: [
        // Input Name
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            context.loc.new_password,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
            hintText: '******',
            contentPadding: EdgeInsets.only(left: 10),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(),
            errorStyle: TextStyle(
              color: Colors.red,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value == '') {
              return context.loc.fill_new_password;
            }
            return null;
          },
          onSaved: (newValue) => setState(() {
            password = newValue;
          }),
        ),
      ],
    );
  }

  Widget updatePasswordTitle(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        context.loc.update_password_from_code,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 32,
        ),
      ),
    );
  }
}
