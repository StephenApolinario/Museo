import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/constants/routes.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/utilities/dialogs/generic_dialog.dart';
import 'package:museo/utilities/registeringOrLogging/generic_textfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlue,
      appBar: AppBar(
        title: Text(
          context.loc.login_title,
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
              // What is your login?
              Align(
                alignment: Alignment.center,
                child: Text(
                  context.loc.login_title_content,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    // Email Textfield
                    // TODO -> Valid if the input its an e-mail address.
                    commonTextField(
                      keyboardType: TextInputType.emailAddress,
                      specifiedController: _email,
                      hintTitle: context.loc.email_hint,
                    ),
                    // Password Textfield
                    commonTextField(
                      specifiedController: _password,
                      hintTitle: context.loc.password_hint,
                      obsecure: true,
                    ),
                    // Forget password
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        child: Text(
                          context.loc.forget_password,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () => {},
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          // Enter
                          const SizedBox(height: 20),
                          TextButton(
                            child: Text(
                              context.loc.enter,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            onPressed: () {
                              final email = _email.text;
                              final password = _password.text;
                              final allFilled =
                                  email.isNotEmpty && password.isNotEmpty;

                              if (allFilled) {
                                showGenericDialog(
                                  // TODO -> Content should be provided by L10N
                                  context: context,
                                  title: 'Congratulations',
                                  content:
                                      'Now, the developer have to create the connection with the databse and create your user kkk',
                                  optionsBuilder: () => {
                                    'Ok': false,
                                  },
                                );
                              } else {
                                showGenericDialog(
                                  context: context,
                                  title: context.loc.dialog_error_ops,
                                  content: context.loc.dialog_error_not_filled,
                                  optionsBuilder: () => {
                                    'Ok': false,
                                  },
                                );
                              }
                            },
                          ),
                          // Not registred yet?
                          TextButton(
                            child: Text(
                              context.loc.not_registred_yet,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () => {
                              Navigator.of(context).pushNamed(register),
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
