import 'package:flutter/material.dart';
import 'package:museo/models/user/user_informations.dart';

PersonalData personalData = PersonalData(
  name: '',
  lastName: '',
  email: '',
  cpf: '',
  birthday: '',
  phoneNumber: '',
);

AddressData addressData = AddressData(
  cep: '',
  state: '',
  city: '',
  neighborhood: '',
  address: '',
  number: '',
  complement: '',
);

class RegisteringFields with ChangeNotifier {
  late UserInformation registerUserInformation = UserInformation(
    personalData: personalData,
    addressData: addressData,
  );

  void updateName(newValue) {
    registerUserInformation.personalData.name = newValue;
    notifyListeners();
  }

  void updateLastName(newValue) {
    registerUserInformation.personalData.lastName = newValue;
    notifyListeners();
  }

  void updateEmail(newValue) {
    registerUserInformation.personalData.email = newValue;
    notifyListeners();
  }

  void updateCPF(newValue) {
    registerUserInformation.personalData.cpf = newValue;
    notifyListeners();
  }

  void updateBirthday(newValue) {
    registerUserInformation.personalData.birthday = newValue;
    notifyListeners();
  }

  void updatePhonenumber(newValue) {
    registerUserInformation.personalData.phoneNumber = newValue;
    notifyListeners();
  }

  void updateCEP(newValue) {
    registerUserInformation.addressData.cep = newValue;
    notifyListeners();
  }

  void updateState(newValue) {
    registerUserInformation.addressData.state = newValue;
    notifyListeners();
  }

  void updateCity(newValue) {
    registerUserInformation.addressData.city = newValue;
    notifyListeners();
  }

  void updateNeighborhood(newValue) {
    registerUserInformation.addressData.neighborhood = newValue;
    notifyListeners();
  }

  void updateHouseAddres(newValue) {
    registerUserInformation.addressData.address = newValue;
    notifyListeners();
  }

  void updateHouseNumber(newValue) {
    registerUserInformation.addressData.number = newValue;
    notifyListeners();
  }

  void updateHouseComplement(newValue) {
    registerUserInformation.addressData.complement = newValue;
    notifyListeners();
  }

  void clear() {
    registerUserInformation.personalData = PersonalData(
      name: '',
      lastName: '',
      email: '',
      cpf: '',
      birthday: '',
      phoneNumber: '',
    );
    registerUserInformation.addressData = AddressData(
      cep: '',
      state: '',
      city: '',
      neighborhood: '',
      address: '',
      number: '',
      complement: '',
    );
    notifyListeners();
  }
}
