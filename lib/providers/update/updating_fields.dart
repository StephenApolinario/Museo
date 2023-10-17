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

class UpdatingFields with ChangeNotifier {
  late UserInformation updateUserInformation = UserInformation(
    personalData: personalData,
    addressData: addressData,
  );

  void updateName(newValue) {
    updateUserInformation.personalData.name = newValue;
    notifyListeners();
  }

  void updateLastName(newValue) {
    updateUserInformation.personalData.lastName = newValue;
    notifyListeners();
  }

  void updateEmail(newValue) {
    updateUserInformation.personalData.email = newValue;
    notifyListeners();
  }

  void updateCPF(newValue) {
    updateUserInformation.personalData.cpf = newValue;
    notifyListeners();
  }

  void updateBirthday(newValue) {
    updateUserInformation.personalData.birthday = newValue;
    notifyListeners();
  }

  void updatePhonenumber(newValue) {
    updateUserInformation.personalData.phoneNumber = newValue;
    notifyListeners();
  }

  void updateCEP(newValue) {
    updateUserInformation.addressData.cep = newValue;
    notifyListeners();
  }

  void updateState(newValue) {
    updateUserInformation.addressData.state = newValue;
    notifyListeners();
  }

  void updateCity(newValue) {
    updateUserInformation.addressData.city = newValue;
    notifyListeners();
  }

  void updateNeighborhood(newValue) {
    updateUserInformation.addressData.neighborhood = newValue;
    notifyListeners();
  }

  void updateHouseAddres(newValue) {
    updateUserInformation.addressData.address = newValue;
    notifyListeners();
  }

  void updateHouseNumber(newValue) {
    updateUserInformation.addressData.number = newValue;
    notifyListeners();
  }

  void updateHouseComplement(newValue) {
    updateUserInformation.addressData.complement = newValue;
    notifyListeners();
  }
}
