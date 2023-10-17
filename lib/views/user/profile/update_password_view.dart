import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';

class UpdatePasswordView extends StatefulWidget {
  const UpdatePasswordView({super.key});

  @override
  State<UpdatePasswordView> createState() => _UpdatePasswordViewState();
}

class _UpdatePasswordViewState extends State<UpdatePasswordView> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController actualPasswordController,
      newPasswordController,
      repeatedNewPasswordController;

  @override
  void initState() {
    newPasswordController = TextEditingController();
    repeatedNewPasswordController = TextEditingController();
    actualPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    repeatedNewPasswordController.dispose();
    actualPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO -> MUST be provided by L10N
        title: const Text(
          'Update Password',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: mainBlue,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_outlined),
          color: Colors.white,
        ),
      ),
      backgroundColor: mainBlue,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      actualPasswordTextField(),
                      newPasswordTextField(),
                      repeatedNewPasswordTextField(),
                      continueButton(context),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget actualPasswordTextField() {
    return Column(
      children: [
        const SizedBox(height: 10),
        const InputTitle(
            title: 'Actual password'), // TODO -> MUST be provided by L10N
        TextFormField(
          obscureText: true,
          controller: actualPasswordController,
          decoration: defaultDecoration,
          validator: (value) {
            if (value != 'teste') {
              // TODO -> Check if the provided password is the actual one
              return 'You enter an incorrect actual password!';
            }
            return null;
          },
        ),
      ],
    );
  }

  newPasswordTextField() {
    return Column(
      children: [
        const SizedBox(height: 10),
        const InputTitle(
            title: 'New Password'), // TODO -> MUST be provided by L10N
        TextFormField(
          obscureText: true,
          controller: newPasswordController,
          decoration: defaultDecoration,
          validator: (value) {
            if (value == null || value == '') {
              return 'Please, provide your password'; // TODO -> MUST be provided by L10N
            } else if (value != repeatedNewPasswordController.text) {
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

  repeatedNewPasswordTextField() {
    return Column(
      children: [
        const SizedBox(height: 10),
        const InputTitle(
            title: 'Repeat new password'), // TODO -> MUST be provided by L10N
        TextFormField(
          obscureText: true,
          controller: repeatedNewPasswordController,
          decoration: defaultDecoration,
          validator: (value) {
            if (value == null || value == '') {
              return 'Please, provide your password'; // TODO -> MUST be provided by L10N
            } else if (value != newPasswordController.text) {
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
              print('Pronto');
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
