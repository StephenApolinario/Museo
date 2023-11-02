class PersonalData {
  late String name, lastName, email, cpf, birthday, phoneNumber;

  PersonalData({
    required this.name,
    required this.lastName,
    required this.email,
    required this.cpf,
    required this.birthday,
    required this.phoneNumber,
  });
}

class AddressData {
  late String cep, state, city, neighborhood, address, number, complement;

  AddressData({
    required this.cep,
    required this.state,
    required this.city,
    required this.neighborhood,
    required this.address,
    required this.number,
    required this.complement,
  });
}

class UserInformation {
  PersonalData personalData;
  AddressData addressData;

  UserInformation({
    required this.personalData,
    required this.addressData,
  });
}
