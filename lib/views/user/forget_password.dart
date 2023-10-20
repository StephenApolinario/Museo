import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/gen/assets.gen.dart';

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
        title: const Text(
          // TODO:  MUST be provided by L10N
          'Esqueci minha senha',
          style: TextStyle(
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
          child: const Text(
            // TODO:  MUST be provided by L10N
            'Enviar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          onPressed: () {
            final isValid = formLoginKey.currentState!.validate();

            if (isValid) {
              formLoginKey.currentState!.save(); // TODO:  Remove this line
            }
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
            decoration: const InputDecoration(
              hintText: 'your@email.com', // TODO:  MUST be provided by L10N
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
              if (value != null) {
                if (!EmailValidator.validate(value)) {
                  return 'Your email is not valid'; // TODO:  MUST be provided by L10N
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
    return const Align(
      alignment: Alignment.center,
      child: Text(
        // TODO:  MUST be provided by L10N
        'Qual seu e-mail?',
        style: TextStyle(
          color: Colors.white,
          fontSize: 32,
        ),
      ),
    );
  }
}
