import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/utilities/dialogs/generic_dialog.dart';
import 'package:museo/utilities/registeringOrLogging/generic_textfield.dart';

class RegisteringAdressDataView extends StatefulWidget {
  const RegisteringAdressDataView({super.key});

  @override
  State<RegisteringAdressDataView> createState() =>
      _RegisteringAdressDataViewState();
}

class _RegisteringAdressDataViewState extends State<RegisteringAdressDataView> {
  late final TextEditingController _cep;
  late final TextEditingController _country;
  late final TextEditingController _state;
  late final TextEditingController _city;
  late final TextEditingController _neighborhood;
  late final TextEditingController _houseAddres;
  late final TextEditingController _houseNumber;
  late final TextEditingController _houseComplement;

  @override
  void initState() {
    _cep = TextEditingController();
    _country = TextEditingController();
    _state = TextEditingController();
    _city = TextEditingController();
    _neighborhood = TextEditingController();
    _houseAddres = TextEditingController();
    _houseNumber = TextEditingController();
    _houseComplement = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _cep.dispose();
    _country.dispose();
    _state.dispose();
    _city.dispose();
    _neighborhood.dispose();
    _houseAddres.dispose();
    _houseNumber.dispose();
    _houseComplement.dispose();
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
                    // TODO -> Make some options selectable? State City Neighborhood
                    // Country
                    commonTextField(
                      specifiedController: _country,
                      hintTitle: context.loc.registering_house_country,
                    ),
                    // Cep
                    // TODO -> Cep type
                    commonTextField(
                      specifiedController: _cep,
                      hintTitle: context.loc.registering_house_CEP,
                    ),
                    // State
                    commonTextField(
                      specifiedController: _state,
                      hintTitle: context.loc.registering_house_state,
                    ),
                    // City
                    commonTextField(
                      specifiedController: _city,
                      hintTitle: context.loc.registering_house_city,
                    ),
                    // Neighborhood
                    commonTextField(
                      specifiedController: _neighborhood,
                      hintTitle: context.loc.registering_house_neighborhood,
                    ),
                    // Address
                    commonTextField(
                      specifiedController: _houseAddres,
                      hintTitle: context.loc.registering_house_address,
                    ),
                    // House Number
                    commonTextField(
                      specifiedController: _houseNumber,
                      hintTitle: context.loc.registering_house_number,
                    ),
                    // House Complement
                    commonTextField(
                      specifiedController: _houseComplement,
                      hintTitle: context.loc.registering_house_complement,
                    ),
                    // Continue Button
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        final cep = _cep.text;
                        final country = _country.text;
                        final state = _state.text;
                        final city = _city.text;
                        final neighborhood = _neighborhood.text;
                        final houseAddres = _houseAddres.text;
                        final houseNumber = _houseNumber.text;
                        final houseComplement = _houseComplement.text;

                        // TODO -> Check if each TextField is valid.
                        final allFilled = cep.isNotEmpty &&
                            country.isNotEmpty &&
                            state.isNotEmpty &&
                            city.isNotEmpty &&
                            neighborhood.isNotEmpty &&
                            houseAddres.isNotEmpty &&
                            houseNumber.isNotEmpty &&
                            houseComplement.isNotEmpty;
                        if (allFilled) {
                          showGenericDialog(
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
                      child: Text(
                        context.loc.continue_message,
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
