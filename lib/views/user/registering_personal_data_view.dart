import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/utilities/dialogs/generic_dialog.dart';
import 'package:museo/utilities/registeringOrLogging/generic_textfield.dart';
import 'package:museo/views/user/registering_adress_data_view.dart';

class RegisteringPersonalDataRegisteringView extends StatefulWidget {
  const RegisteringPersonalDataRegisteringView({super.key});

  @override
  State<RegisteringPersonalDataRegisteringView> createState() =>
      _RegisteringPersonalDataRegisteringViewState();
}

class _RegisteringPersonalDataRegisteringViewState
    extends State<RegisteringPersonalDataRegisteringView> {
  late final TextEditingController _name;
  late final TextEditingController _lastName;
  late final TextEditingController _email;
  late final TextEditingController _cpf;
  late final TextEditingController _birthday;
  late final TextEditingController _phoneNumber;

  @override
  void initState() {
    _name = TextEditingController();
    _lastName = TextEditingController();
    _email = TextEditingController();
    _cpf = TextEditingController();
    _birthday = TextEditingController();
    _phoneNumber = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _lastName.dispose();
    _email.dispose();
    _cpf.dispose();
    _birthday.dispose();
    _phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlue,
      appBar: AppBar(
        title: Text(
          context.loc.registering_title,
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
              // Create your account && Personal data
              Center(
                child: Column(
                  children: [
                    Text(
                      context.loc.registering_content_title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                    Text(
                      context.loc.registering_personal_data_content_subtitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    // Name Textfield
                    commonTextField(
                      specifiedController: _name,
                      hintTitle: context.loc.registering_name,
                    ),
                    // lastname title
                    commonTextField(
                      specifiedController: _lastName,
                      hintTitle: context.loc.registering_lastname,
                    ),
                    // Email title
                    commonTextField(
                      specifiedController: _email,
                      hintTitle: context.loc.registering_email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    // CPF title TODO -> Create CPF Type
                    commonTextField(
                      specifiedController: _cpf,
                      hintTitle: context.loc.registering_CPF,
                      keyboardType: TextInputType.datetime,
                    ),
                    // Birthday title TODO -> Create Birthday Type
                    commonTextField(
                      specifiedController: _birthday,
                      hintTitle: context.loc.registering_birthday,
                      keyboardType: TextInputType.datetime,
                    ),
                    // Phone title TODO -> Create Phone Type
                    commonTextField(
                      specifiedController: _phoneNumber,
                      hintTitle: context.loc.registering_phonenumber,
                      keyboardType: TextInputType.datetime,
                    ),
                    // Continue Button
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        final name = _name.text;
                        final lastName = _lastName.text;
                        final email = _email.text;
                        final cpf = _cpf.text;
                        final birthday = _birthday.text;
                        final phoneNumber = _phoneNumber.text;

                        // TODO -> Check if each TextField is valid.
                        final allFilled = name.isNotEmpty &&
                            lastName.isNotEmpty &&
                            email.isNotEmpty &&
                            cpf.isNotEmpty &&
                            birthday.isNotEmpty &&
                            phoneNumber.isNotEmpty;
                        if (allFilled) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RegisteringAdressDataView(),
                            ),
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
                      child: Text(
                        context.loc.registering_continue_button,
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
