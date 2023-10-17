import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/models/user/registering.dart';
import 'package:museo/providers/register/registerig_fields.dart';
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

class RegisteringAddressData extends StatefulWidget {
  final RegisteringTitleSubtitle registerTitleSubtitle;
  final PageController pageController;

  const RegisteringAddressData({
    super.key,
    required this.registerTitleSubtitle,
    required this.pageController,
  });

  @override
  State<RegisteringAddressData> createState() => _RegisteringAddressDataState();
}

class _RegisteringAddressDataState extends State<RegisteringAddressData> {
  final formKey = GlobalKey<FormState>();
  late RegisteringFields registeringFields;
  late final TextEditingController cepController,
      stateController,
      cityController,
      neighborhoodController,
      addressController;

  @override
  void initState() {
    registeringFields = Provider.of<RegisteringFields>(context, listen: false);

    cepController = TextEditingController(
      text: registeringFields.registerUserInformation.addressData.cep,
    );

    stateController = TextEditingController(
      text: registeringFields.registerUserInformation.addressData.state,
    );

    cityController = TextEditingController(
      text: registeringFields.registerUserInformation.addressData.city,
    );

    neighborhoodController = TextEditingController(
      text: registeringFields.registerUserInformation.addressData.neighborhood,
    );

    addressController = TextEditingController(
      text: registeringFields.registerUserInformation.addressData.address,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    stateController.text = Provider.of<RegisteringFields>(
      context,
      listen: true,
    ).registerUserInformation.addressData.state;

    cityController.text = Provider.of<RegisteringFields>(
      context,
      listen: true,
    ).registerUserInformation.addressData.city;

    neighborhoodController.text = Provider.of<RegisteringFields>(
      context,
      listen: true,
    ).registerUserInformation.addressData.neighborhood;

    addressController.text = Provider.of<RegisteringFields>(
      context,
      listen: true,
    ).registerUserInformation.addressData.address;

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

    registeringFields.updateCEP(houseAddress.cep);
    registeringFields.updateHouseAddres(houseAddress.houseAddress);
    registeringFields.updateHouseComplement(houseAddress.complement);
    registeringFields.updateNeighborhood(houseAddress.neighborhood);
    registeringFields.updateCity(houseAddress.city);
    registeringFields.updateState(houseAddress.uf);
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
              formKey.currentState!.save();
              widget.pageController.nextPage(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInExpo,
              );
            }
          },
          child: Text(
            context.loc.continue_message,
          ),
        ),
      ],
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
            onSaved: (newValue) => registeringFields.updateCEP(newValue),
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
          onSaved: (newValue) => registeringFields.updateState(newValue),
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
          onSaved: (newValue) => registeringFields.updateCity(newValue),
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
          onSaved: (newValue) => registeringFields.updateNeighborhood(newValue),
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
          onSaved: (newValue) => registeringFields.updateHouseAddres(newValue),
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
          initialValue:
              registeringFields.registerUserInformation.addressData.number,
          decoration: defaultDecoration,
          validator: (value) => defaultValidator(
            value: value,
            message:
                'Please, fill your house number', // TODO -> MUST be provided by L10N
          ),
          onSaved: (newValue) => registeringFields.updateHouseNumber(newValue),
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
              registeringFields.registerUserInformation.addressData.complement,
          decoration: defaultDecoration,
          onSaved: (newValue) =>
              registeringFields.updateHouseComplement(newValue),
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
