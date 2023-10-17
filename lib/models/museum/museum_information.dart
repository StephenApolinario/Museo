// Monday = 1 | Tuesday = 2 | Wednesday = 3 | Thursday = 4 | Friday = 5 | Saturday = 6 | Sunday = 7
class OperatingDays {
  final int open, close, day;

  OperatingDays({
    required this.day,
    required this.open,
    required this.close,
  });
}

class MuseumAddress {
  String country, state, city, phoneNumber, email;

  MuseumAddress({
    required this.country,
    required this.state,
    required this.city,
    required this.phoneNumber,
    required this.email,
  });
}

final MuseumAddress fakeMuseumAddress = MuseumAddress(
  country: 'Brazil',
  state: 'SC',
  city: 'Balenário Piçarras',
  phoneNumber: '(47) 3341-5570',
  email: 'educacao.movi@univali.br',
);

final List<OperatingDays> fakeOperatingDays = [
  OperatingDays(day: 2, open: 14, close: 17),
  OperatingDays(day: 3, open: 14, close: 17),
  OperatingDays(day: 4, open: 14, close: 17),
  OperatingDays(day: 5, open: 14, close: 17),
  OperatingDays(day: 6, open: 14, close: 17),
  OperatingDays(day: 7, open: 14, close: 17),
];
