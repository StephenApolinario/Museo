import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/utilities/registeringOrLogging/generic_textfield.dart';
import 'package:museo/views/user/registering_personal_data_view.dart';

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
                    commonTextField(
                      specifiedController: _email,
                      hintTitle: context.loc.email_hint,
                    ),
                    // Password Textfield
                    commonTextField(
                      specifiedController: _password,
                      hintTitle: context.loc.password_hint,
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
                            onPressed: () => {},
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
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const RegisteringPersonalDataRegisteringView(),
                              ))
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
