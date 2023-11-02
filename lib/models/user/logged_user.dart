class LoggedUser {
  String name;
  String lastName;
  String email;
  String cpf;
  String birthday;
  String phoneNumber;
  String cep;
  String state;
  String city;
  String neighborhood;
  String address;
  String number;
  String complement;
  String picture;
  List<dynamic> favorites;
  List<dynamic> emblems;
  List<dynamic> quizPerformances;

  LoggedUser({
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
    required this.emblems,
    required this.quizPerformances,
    required this.favorites,
  });

  factory LoggedUser.fromJson(Map<String, dynamic> json) => LoggedUser(
        name: json['name'],
        lastName: json['lastName'],
        email: json['email'],
        cpf: json['cpf'],
        birthday: json['birthday'],
        phoneNumber: json['phoneNumber'],
        cep: json['cep'],
        state: json['state'],
        city: json['city'],
        neighborhood: json['neighborhood'],
        address: json['address'],
        number: json['number'],
        complement: json['complement'],
        picture: json['picture'],
        emblems: List<dynamic>.from(
          json['emblems'].map((x) => x),
        ),
        quizPerformances: List<dynamic>.from(
          json['quizPerformances'].map((x) => x),
        ),
        favorites: List<dynamic>.from(
          json['favorites'].map((x) => x),
        ),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'lastName': lastName,
        'email': email,
        'cpf': cpf,
        'birthday': birthday,
        'phoneNumber': phoneNumber,
        'cep': cep,
        'state': state,
        'city': city,
        'neighborhood': neighborhood,
        'address': address,
        'number': number,
        'complement': complement,
        'picture': picture,
        'emblems': List<dynamic>.from(emblems.map((x) => x)),
        'quizPerformances': List<dynamic>.from(quizPerformances.map((x) => x)),
        'favorites': List<dynamic>.from(favorites.map((x) => x)),
      };

  void clearUserData() {
    name = '';
    lastName = '';
    email = '';
    cpf = '';
    birthday = '';
    phoneNumber = '';
    cep = '';
    state = '';
    city = '';
    neighborhood = '';
    address = '';
    number = '';
    complement = '';
    picture = '';
    emblems.clear();
    quizPerformances.clear();
  }
}
