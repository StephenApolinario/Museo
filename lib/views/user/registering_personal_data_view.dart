import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/utilities/registeringOrLogging/generic_textfield.dart';
import 'package:museo/views/user/registering_adress_data_view.dart';

class RegisteringPersonalDataRegisteringView extends StatelessWidget {
  const RegisteringPersonalDataRegisteringView({super.key});

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
                      hintTitle: context.loc.registering_name,
                    ),
                    // Surname title
                    commonTextField(
                      hintTitle: context.loc.registering_surname,
                    ),
                    // Email title
                    commonTextField(
                      hintTitle: context.loc.registering_email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    // CPF title TODO -> Create CPF Type
                    commonTextField(
                      hintTitle: context.loc.registering_CPF,
                    ),
                    // Birthday title TODO -> Create Birthday Type
                    commonTextField(
                      hintTitle: context.loc.registering_birthday,
                    ),
                    // Phone title TODO -> Create Phone Type
                    commonTextField(
                      hintTitle: context.loc.registering_phonenumber,
                    ),
                    // Continue Button
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                const RegisteringAdressDataView(),
                          ),
                        ),
                      },
                      child: Text(
                        context.loc.registering_continue_button,
                      ),
                    )
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
