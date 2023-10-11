import 'package:flutter/material.dart';
import 'package:museo/models/museum_information.dart';
import 'package:museo/views/store/tickets/components/build_container_day.dart';

class DaysType {
  final DateTime day;
  bool isSelected;

  DaysType({
    required this.day,
    this.isSelected = false,
  });
}

class BuildDateSelector extends StatefulWidget {
  final void Function(DateTime) selectDate;

  const BuildDateSelector({
    super.key,
    required this.selectDate,
  });

  @override
  State<BuildDateSelector> createState() => _BuildDateSelectorState();
}

class _BuildDateSelectorState extends State<BuildDateSelector> {
  late List<DaysType> daysList;

  @override
  void initState() {
    generateDaysList();
    super.initState();
  }

  void generateDaysList() {
    DateTime today = DateTime.now();
    DateTime initialDate = checkNextOpenDay(today: today);
    // 7 * 4 => 4 weeks to the future is the limit of the list.
    // Create a list that add 7 * 4 days to the future (4 weeks)
    daysList = List.generate(7 * 8, (index) {
      return DaysType(
        day: initialDate.add(Duration(days: index)),
        isSelected: index == 0 ? true : false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final String? language =
        Localizations.maybeLocaleOf(context)?.toLanguageTag();

    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: daysList.length,
        itemBuilder: (context, index) {
          return BuildContainerDay(
            index: index,
            daysList: daysList,
            language: language,
            selectDate: widget.selectDate,
          );
        },
      ),
    );
  }

  DateTime checkNextOpenDay({required DateTime today}) {
    int minDifferenceDays = 9;
    for (OperatingDays day in fakeOperatingDays) {
      int difference = (day.day - today.weekday + 7) %
          7; // Calculate the positive difference
      if (difference < minDifferenceDays) {
        minDifferenceDays = difference;
      }
    }

    bool museumIsClosed =
        fakeOperatingDays.any((element) => today.hour > element.close);

    if (museumIsClosed && minDifferenceDays == 0) {
      minDifferenceDays += 1;
    }

    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ).add(Duration(days: minDifferenceDays));
  }
}
