import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/utilities/registeringOrLogging/generic_textfield.dart';

class RegisteringAdressDataView extends StatelessWidget {
  const RegisteringAdressDataView({super.key});

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
              // Create your account && Address data
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
                      context.loc.registering_address_data_content_subtitle,
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
                    // Cep
                    commonTextField(
                      hintTitle: context.loc.registering_house_CEP,
                    ),
                    // Country
                    commonTextField(
                      hintTitle: context.loc.registering_house_country,
                    ),
                    // State
                    commonTextField(
                      hintTitle: context.loc.registering_house_state,
                    ),
                    // City
                    commonTextField(
                      hintTitle: context.loc.registering_house_city,
                    ),
                    // Neighborhood
                    commonTextField(
                      hintTitle: context.loc.registering_house_neighborhood,
                    ),
                    // Address
                    commonTextField(
                      hintTitle: context.loc.registering_house_address,
                    ),
                    // House Number
                    commonTextField(
                      hintTitle: context.loc.registering_house_number,
                    ),
                    // House Complement
                    commonTextField(
                      hintTitle: context.loc.registering_house_complement,
                    ),
                    // Continue Button
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () => {},
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
