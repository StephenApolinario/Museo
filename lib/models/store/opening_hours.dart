// Monday = 1 | Tuesday = 2 | Wednesday = 3 | Thursday = 4 | Friday = 5 | Saturday = 6 | Sunday = 7
class OperatingDays {
  final int day;
  final int open, close;

  OperatingDays({
    required this.day,
    required this.open,
    required this.close,
  });
}

final List<OperatingDays> operatingDays = [
  OperatingDays(day: 2, open: 14, close: 17),
  OperatingDays(day: 3, open: 14, close: 17),
  OperatingDays(day: 4, open: 14, close: 17),
  OperatingDays(day: 5, open: 14, close: 17),
  OperatingDays(day: 6, open: 14, close: 17),
  OperatingDays(day: 7, open: 14, close: 17),
];
