import 'package:brasil_fields/brasil_fields.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/extensions/string.dart';
import 'package:museo/models/user/update_informations.dart';
import 'package:museo/providers/update/updating_fields.dart';
import 'package:provider/provider.dart';

class UpdatePersonalData extends StatefulWidget {
  final UpdateInformationTitle updatingTitleSubtitle;
  final PageController pageController;

  const UpdatePersonalData({
    super.key,
    required this.updatingTitleSubtitle,
    required this.pageController,
  });

  @override
  State<UpdatePersonalData> createState() => _UpdatePersonalDataState();
}

class _UpdatePersonalDataState extends State<UpdatePersonalData> {
  final formKey = GlobalKey<FormState>();
  late UpdatingFields updatingFields;

  @override
  void initState() {
    updatingFields = Provider.of<UpdatingFields>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            buildTitle(updateTitleSubtitle: widget.updatingTitleSubtitle),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  nameTextField(),
                  lastNameTextField(),
                  emailTextField(),
                  cpfTextField(),
                  birthdayTextField(),
                  phoneNumberTextField(),
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

  nameTextField() {
    return Column(
      children: [
        const SizedBox(height: 10),
        InputTitle(
          title: context.loc.registering_name,
        ),
        TextFormField(
          initialValue: updatingFields.updateUserInformation.personalData.name,
          decoration: defaultDecoration,
          validator: (value) => defaultValidator(
            value: value,
            message:
                'Please, fill your name', // TODO:  MUST be provided by L10N
          ),
          onSaved: (newValue) => updatingFields.updateName(newValue),
        ),
      ],
    );
  }

  lastNameTextField() {
    return Column(
      children: [
        const SizedBox(height: 10),
        InputTitle(
          title: context.loc.registering_lastname,
        ),
        TextFormField(
          initialValue: updatingFields
              .updateUserInformation.personalData.lastName
              .toCapitalized(),
          decoration: defaultDecoration,
          validator: (value) => defaultValidator(
            value: value,
            message:
                'Please, fill your last name', // TODO:  MUST be provided by L10N
          ),
          onSaved: (newValue) => updatingFields.updateLastName(newValue),
        ),
      ],
    );
  }

  emailTextField() {
    return Column(
      children: [
        const SizedBox(height: 10),
        InputTitle(
          title: context.loc.registering_email,
        ),
        TextFormField(
          initialValue: updatingFields.updateUserInformation.personalData.email,
          decoration: defaultDecoration,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value != null && !EmailValidator.validate(value)) {
              return 'Please write a valid email'; // TODO:  MUST be provided by L10N
            }

            return null;
          },
          onSaved: (newValue) => updatingFields.updateEmail(newValue),
        ),
      ],
    );
  }

  cpfTextField() {
    return Column(
      children: [
        const SizedBox(height: 10),
        InputTitle(
          title: context.loc.registering_CPF,
        ),
        TextFormField(
          initialValue: updatingFields.updateUserInformation.personalData.cpf,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CpfInputFormatter(),
          ],
          decoration: defaultDecoration,
          validator: (value) => defaultValidator(
            value: value,
            message: 'Please, fill your CPF', // TODO:  MUST be provided by L10N
          ),
          onSaved: (newValue) => updatingFields.updateCPF(newValue),
        ),
      ],
    );
  }

  birthdayTextField() {
    return Column(
      children: [
        const SizedBox(height: 10),
        InputTitle(
          title: context.loc.registering_birthday,
        ),
        TextFormField(
          initialValue:
              updatingFields.updateUserInformation.personalData.birthday,
          keyboardType: TextInputType.datetime,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            DataInputFormatter(),
          ],
          decoration: defaultDecoration,
          validator: (value) => defaultValidator(
            value: value,
            message:
                'Please, fill your birthday', // TODO:  MUST be provided by L10N
          ),
          onSaved: (newValue) => updatingFields.updateBirthday(newValue),
        ),
      ],
    );
  }

  phoneNumberTextField() {
    return Column(
      children: [
        const SizedBox(height: 10),
        InputTitle(
          title: context.loc.registering_phonenumber,
        ),
        TextFormField(
          initialValue:
              updatingFields.updateUserInformation.personalData.phoneNumber,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            TelefoneInputFormatter(),
          ],
          decoration: defaultDecoration,
          validator: (value) => defaultValidator(
            value: value,
            message:
                'Please, fill your phone number', // TODO:  MUST be provided by L10N
          ),
          onSaved: (newValue) => updatingFields.updatePhonenumber(newValue),
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
