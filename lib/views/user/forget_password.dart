import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/constants/routes.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/gen/assets.gen.dart';
import 'package:museo/helpers/loading_complete.dart';
import 'package:museo/services/user_service.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final formLoginKey = GlobalKey<FormState>();
  late String? email;
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
                    forgetPasswordTitle(context),
                    emailInput(context),
                    sendButton(context),
                    alreadyHaveCode(context),
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
              loadingIndicatorTime(
                title: context.loc.wait_a_second,
                context: context,
              );
              final sendEmail =
                  await UserService().sendResetPasswordLink(context, email!);
              if (context.mounted) {
                loadingMessageTime(
                  title: sendEmail == 'error'
                      ? context.loc.dialog_error_ops
                      : context.loc.successful,
                  subtitle: sendEmail == 'error'
                      ? context.loc.email_send_failed
                      : context.loc.email_send_success,
                  context: context,
                );
              }
            }
          },
        ),
      ],
    );
  }

  Widget alreadyHaveCode(BuildContext context) {
    return Column(
      children: [
        // Enter
        const SizedBox(height: 20),
        TextButton(
          child: Text(
            context.loc.already_have_code,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(userGetNewPassword);
          },
        ),
      ],
    );
  }

  Widget emailInput(BuildContext context) {
    return Form(
      key: formLoginKey,
      child: Column(
        children: [
          // Input Name
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              context.loc.email_hint,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: context.loc.your_email_example,
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
              if (value != null) {
                if (!EmailValidator.validate(value)) {
                  return context.loc.email_not_valid;
                }
              }
              return null;
            },
            onSaved: (newValue) => setState(() {
              email = newValue;
            }),
          ),
        ],
      ),
    );
  }

  Widget forgetPasswordTitle(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        context.loc.what_is_your_email,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 32,
        ),
      ),
    );
  }
}
