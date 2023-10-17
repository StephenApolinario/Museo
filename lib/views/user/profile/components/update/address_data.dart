import 'dart:convert';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/models/user/update_informations.dart';
import 'package:museo/providers/update/updating_fields.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HouseAddress {
  String cep, houseAddress, complement, neighborhood, city, uf;

  HouseAddress({
    required this.cep,
    required this.houseAddress,
    required this.complement,
    required this.neighborhood,
    required this.city,
    required this.uf,
  });

  HouseAddress.fromjson(Map<String, dynamic> json)
      : cep = json['cep'],
        houseAddress = json['logradouro'],
        complement = json['complemento'],
        neighborhood = json['bairro'],
        city = json['localidade'],
        uf = json['uf'];
}

class UpdateAddressData extends StatefulWidget {
  final UpdateInformationTitle registerTitleSubtitle;
  final PageController pageController;

  const UpdateAddressData({
    super.key,
    required this.registerTitleSubtitle,
    required this.pageController,
  });

  @override
  State<UpdateAddressData> createState() => _UpdateAddressDataState();
}

class _UpdateAddressDataState extends State<UpdateAddressData> {
  final formKey = GlobalKey<FormState>();
  late UpdatingFields updatingFields;
  late final TextEditingController cepController,
      stateController,
      cityController,
      neighborhoodController,
      addressController;

  @override
  void initState() {
    updatingFields = Provider.of<UpdatingFields>(context, listen: false);

    cepController = TextEditingController(
      text: updatingFields.updateUserInformation.addressData.cep,
    );

    stateController = TextEditingController(
      text: updatingFields.updateUserInformation.addressData.state,
    );

    cityController = TextEditingController(
      text: updatingFields.updateUserInformation.addressData.city,
    );

    neighborhoodController = TextEditingController(
      text: updatingFields.updateUserInformation.addressData.neighborhood,
    );

    addressController = TextEditingController(
      text: updatingFields.updateUserInformation.addressData.address,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    stateController.text = Provider.of<UpdatingFields>(
      context,
      listen: true,
    ).updateUserInformation.addressData.state;

    cityController.text = Provider.of<UpdatingFields>(
      context,
      listen: true,
    ).updateUserInformation.addressData.city;

    neighborhoodController.text = Provider.of<UpdatingFields>(
      context,
      listen: true,
    ).updateUserInformation.addressData.neighborhood;

    addressController.text = Provider.of<UpdatingFields>(
      context,
      listen: true,
    ).updateUserInformation.addressData.address;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    cepController.dispose();
    stateController.dispose();
    super.dispose();
  }

  void searchCep({required String cep}) async {
    cep = cep.replaceAll(RegExp(r'[^0-9]'), ''); //Only digits
    Uri url = Uri(
      scheme: 'https',
      host: 'viacep.com.br',
      path: '/ws/$cep/json',
    );
    http.Response response = await http.get(url);

    if (response.statusCode != 200 || response.body.contains('erro')) {
      return;
    }

    HouseAddress houseAddress =
        HouseAddress.fromjson(jsonDecode(response.body));

    updatingFields.updateCEP(houseAddress.cep);
    updatingFields.updateHouseAddres(houseAddress.houseAddress);
    updatingFields.updateHouseComplement(houseAddress.complement);
    updatingFields.updateNeighborhood(houseAddress.neighborhood);
    updatingFields.updateCity(houseAddress.city);
    updatingFields.updateState(houseAddress.uf);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            buildTitle(updateTitleSubtitle: widget.registerTitleSubtitle),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  cepTextField(), // TODO -> Valid if the input is an CEP.
                  stateTextField(),
                  cityTextField(),
                  neighborhoodTextField(),
                  houseAddresTextField(),
                  houseNumberTextField(),
                  houseComplementTextField(),
                  continueButton(context),
                ],
              ),
            )
          ],
        ),
      ),
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
              print(updatingFields.updateUserInformation.addressData.address);
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

  Widget buildTitle({required UpdateInformationTitle updateTitleSubtitle}) {
    return Center(
      child: Column(
        children: [
          Text(
            updateTitleSubtitle.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
            ),
          ),
        ],
      ),
    );
  }

  cepTextField() {
    return Focus(
      child: Column(
        children: [
          const SizedBox(height: 10),
          const InputTitle(title: 'CEP'), // TODO -> MUST be provided by L10N
          TextFormField(
            controller: cepController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter(),
            ],
            decoration: defaultDecoration,
            validator: (value) => defaultValidator(
              value: value,
              message:
                  'Please, fill your CEP', // TODO -> MUST be provided by L10N
            ),
            onSaved: (newValue) => updatingFields.updateCEP(newValue),
          ),
        ],
      ),
      onFocusChange: (value) => searchCep(cep: cepController.text),
    );
  }

  stateTextField() {
    return Column(
      children: [
        const SizedBox(height: 10),
        InputTitle(title: context.loc.registering_house_state),
        TextFormField(
          controller: stateController,
          decoration: defaultDecoration,
          validator: (value) => defaultValidator(
            value: value,
            message:
                'Please, fill your state', // TODO -> MUST be provided by L10N
          ),
          onSaved: (newValue) => updatingFields.updateState(newValue),
        ),
      ],
    );
  }

  cityTextField() {
    return Column(
      children: [
        const SizedBox(height: 10),
        InputTitle(title: context.loc.registering_house_city),
        TextFormField(
          controller: cityController,
          decoration: defaultDecoration,
          validator: (value) => defaultValidator(
            value: value,
            message:
                'Please, fill your city', // TODO -> MUST be provided by L10N
          ),
          onSaved: (newValue) => updatingFields.updateCity(newValue),
        ),
      ],
    );
  }

  neighborhoodTextField() {
    return Column(
      children: [
        const SizedBox(height: 10),
        InputTitle(title: context.loc.registering_house_neighborhood),
        TextFormField(
          controller: neighborhoodController,
          decoration: defaultDecoration,
          validator: (value) => defaultValidator(
            value: value,
            message:
                'Please, fill your neighborhood', // TODO -> MUST be provided by L10N
          ),
          onSaved: (newValue) => updatingFields.updateNeighborhood(newValue),
        ),
      ],
    );
  }

  houseAddresTextField() {
    return Column(
      children: [
        const SizedBox(height: 10),
        InputTitle(title: context.loc.registering_house_address),
        TextFormField(
          controller: addressController,
          decoration: defaultDecoration,
          validator: (value) => defaultValidator(
            value: value,
            message:
                'Please, fill your house address', // TODO -> MUST be provided by L10N
          ),
          onSaved: (newValue) => updatingFields.updateHouseAddres(newValue),
        ),
      ],
    );
  }

  houseNumberTextField() {
    return Column(
      children: [
        const SizedBox(height: 10),
        InputTitle(
          title: context.loc.registering_house_number,
        ),
        TextFormField(
          initialValue: updatingFields.updateUserInformation.addressData.number,
          decoration: defaultDecoration,
          validator: (value) => defaultValidator(
            value: value,
            message:
                'Please, fill your house number', // TODO -> MUST be provided by L10N
          ),
          onSaved: (newValue) => updatingFields.updateHouseNumber(newValue),
        ),
      ],
    );
  }

  houseComplementTextField() {
    return Column(
      children: [
        const SizedBox(height: 10),
        InputTitle(
          title: context.loc.registering_house_complement,
        ),
        TextFormField(
          initialValue:
              updatingFields.updateUserInformation.addressData.complement,
          decoration: defaultDecoration,
          onSaved: (newValue) => updatingFields.updateHouseComplement(newValue),
        ),
      ],
    );
  }
}

defaultValidator({required String? value, required String message}) {
  if (value == null || value.isEmpty) {
    return message;
  }
  return null;
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
