import 'package:flutter/material.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/models/user/registering.dart';
import 'package:museo/providers/register/registerig_fields.dart';
import 'package:provider/provider.dart';

class RegisteringPasswordData extends StatefulWidget {
  final RegisteringTitleSubtitle registerTitleSubtitle;
  final PageController pageController;

  const RegisteringPasswordData({
    super.key,
    required this.registerTitleSubtitle,
    required this.pageController,
  });

  @override
  State<RegisteringPasswordData> createState() =>
      _RegisteringPasswordDataState();
}

class _RegisteringPasswordDataState extends State<RegisteringPasswordData> {
  late RegisteringFields registeringFields;

  final formKey = GlobalKey<FormState>();
  late final TextEditingController passwordController,
      repeatedPasswordController;

  @override
  void initState() {
    registeringFields = Provider.of<RegisteringFields>(context, listen: false);
    passwordController = TextEditingController();
    repeatedPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    repeatedPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            buildTitle(registerTitleSubtitle: widget.registerTitleSubtitle),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  passwordTextField(),
                  repeatedPasswordTextField(),
                  continueButton(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTitle({required RegisteringTitleSubtitle registerTitleSubtitle}) {
    return Center(
      child: Column(
        children: [
          Text(
            registerTitleSubtitle.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
            ),
          ),
          Text(
            registerTitleSubtitle.subtitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  passwordTextField() {
    return Column(
      children: [
        const SizedBox(height: 10),
        const InputTitle(title: 'Password'), // TODO -> MUST be provided by L10N
        TextFormField(
          obscureText: true,
          controller: passwordController,
          decoration: defaultDecoration,
          validator: (value) {
            if (value == null || value == '') {
              return 'Please, provide your password'; // TODO -> MUST be provided by L10N
            } else if (value != repeatedPasswordController.text) {
              return 'The passwords must match!'; // TODO -> MUST be provided by L10N
            } else if (value.length < 4) {
              return 'The password must have at least 4 characters'; // TODO -> MUST be provided by L10N
            }
            return null;
          },
        ),
      ],
    );
  }

  repeatedPasswordTextField() {
    return Column(
      children: [
        const SizedBox(height: 10),
        const InputTitle(
            title: 'Repeat password'), // TODO -> MUST be provided by L10N
        TextFormField(
          obscureText: true,
          controller: repeatedPasswordController,
          decoration: defaultDecoration,
          validator: (value) {
            if (value == null || value == '') {
              return 'Please, provide your password'; // TODO -> MUST be provided by L10N
            } else if (value != passwordController.text) {
              return 'The passwords must match!'; // TODO -> MUST be provided by L10N
            } else if (value.length < 4) {
              return 'The password must have at least 4 characters'; // TODO -> MUST be provided by L10N
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget continueButton(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            final isValid = formKey.currentState!.validate();
            if (isValid) {
              print(registeringFields
                  .registerUserInformation.addressData.address);
              //TODO -> Create the user info into database, and redirect to the login page.
              //TODO -> Clear the class UserInformation
            }
          },
          child: Text(
            context.loc.continue_message,
          ),
        ),
      ],
    );
  }
}

class InputTitle extends StatelessWidget {
  final String title;

  const InputTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}

InputDecoration defaultDecoration = const InputDecoration(
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
);
