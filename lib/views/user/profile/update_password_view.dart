import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/services/user_service.dart';

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
        title: Text(
          context.loc.update_password,
          style: const TextStyle(
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
        InputTitle(
          title: context.loc.current_password,
        ),
        TextFormField(
          obscureText: true,
          controller: actualPasswordController,
          decoration: defaultDecoration,
          validator: (value) {
            if (value == null || value == '') {
              return context.loc.fill_current_password;
            } else if (value.length < 4) {
              return context.loc.current_password_min_characters;
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
        InputTitle(
          title: context.loc.new_password,
        ),
        TextFormField(
          obscureText: true,
          controller: newPasswordController,
          decoration: defaultDecoration,
          validator: (value) {
            if (value == null || value == '') {
              return context.loc.fill_new_password;
            } else if (value != repeatedNewPasswordController.text) {
              return context.loc.password_match;
            } else if (value.length < 4) {
              return context.loc.password_min_characters;
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
        InputTitle(
          title: context.loc.repeat_new_password,
        ),
        TextFormField(
          obscureText: true,
          controller: repeatedNewPasswordController,
          decoration: defaultDecoration,
          validator: (value) {
            if (value == null || value == '') {
              return context.loc.fill_new_password;
            } else if (value != newPasswordController.text) {
              return context.loc.password_match;
            } else if (value.length < 4) {
              return context.loc.password_min_characters;
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
            FocusManager.instance.primaryFocus?.unfocus();
            final isValid = formKey.currentState!.validate();
            if (isValid) {
              UserService().updatePasword(
                  context: context,
                  actualPassword: actualPasswordController.text,
                  newPassword: newPasswordController.text);
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
