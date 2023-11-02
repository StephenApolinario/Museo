import 'package:intl/intl.dart';

class UpdatingUser {
  final String name,
      lastName,
      email,
      cpf,
      phoneNumber,
      cep,
      state,
      city,
      neighborhood,
      address,
      number,
      complement,
      picture;
  final DateTime birthday;

  UpdatingUser({
    required this.name,
    required this.lastName,
    required this.email,
    required this.cpf,
    required this.birthday,
    required this.phoneNumber,
    required this.cep,
    required this.state,
    required this.city,
    required this.neighborhood,
    required this.address,
    required this.number,
    required this.complement,
    required this.picture,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastName': lastName,
      'email': email,
      'cpf': cpf,
      'birthday': DateFormat('MM/dd/yyyy')
          .format(birthday), // Format the birthday as a string
      'phoneNumber': phoneNumber,
      'cep': cep,
      'state': state,
      'city': city,
      'neighborhood': neighborhood,
      'address': address,
      'number': number,
      'complement': complement,
      'picture': picture,
    };
  }
}
