// Monday = 1 | Tuesday = 2 | Wednesday = 3 | Thursday = 4 | Friday = 5 | Saturday = 6 | Sunday = 7

// TODO: 1. Use the operation days on the admin app + API.
class OperatingDays {
  final int open, close, day;

  OperatingDays({
    required this.day,
    required this.open,
    required this.close,
  });
}

final List<OperatingDays> fakeOperatingDays = [
  OperatingDays(day: 2, open: 14, close: 17),
  OperatingDays(day: 3, open: 14, close: 17),
  OperatingDays(day: 4, open: 14, close: 17),
  OperatingDays(day: 5, open: 14, close: 17),
  OperatingDays(day: 6, open: 14, close: 17),
  OperatingDays(day: 7, open: 14, close: 17),
];

class MuseumPhone {
  String phoneNumber;

  MuseumPhone({
    required this.phoneNumber,
  });

  factory MuseumPhone.fromJson(Map<String, dynamic> json) {
    return MuseumPhone(phoneNumber: json['phoneNumber']);
  }
}

class MuseumEmail {
  String email;

  MuseumEmail({
    required this.email,
  });

  factory MuseumEmail.fromJson(Map<String, dynamic> json) {
    return MuseumEmail(email: json['email']);
  }
}

class MuseumInformation {
  String country,
      state,
      city,
      neighborhood,
      street,
      streetNumber,
      zip,
      instagram;
  List<MuseumPhone> phoneList;
  List<MuseumEmail> emailList;

  MuseumInformation({
    required this.country,
    required this.state,
    required this.city,
    required this.neighborhood,
    required this.street,
    required this.streetNumber,
    required this.zip,
    required this.instagram,
    required this.emailList,
    required this.phoneList,
  });

  factory MuseumInformation.fromJson(Map<String, dynamic> json) {
    var phoneListJson = json['phoneNumberList'] as List<dynamic>;
    var emailListJson = json['emailList'] as List<dynamic>;

    List<MuseumPhone> phoneList = phoneListJson
        .map(
          (phoneJson) => MuseumPhone(phoneNumber: phoneJson['phoneNumber']),
        )
        .toList();

    List<MuseumEmail> emailList = emailListJson
        .map(
          (emailJson) => MuseumEmail(email: emailJson['email']),
        )
        .toList();

    return MuseumInformation(
      country: json['country'],
      state: json['state'],
      city: json['city'],
      neighborhood: json['neighborhood'],
      street: json['street'],
      streetNumber: json['streetNumber'],
      zip: json['zip'],
      instagram: json['instagram'],
      emailList: emailList,
      phoneList: phoneList,
    );
  }
}
