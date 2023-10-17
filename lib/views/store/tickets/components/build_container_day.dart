import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/providers/store/shopping_ticket_cart.dart';
import 'package:museo/views/store/tickets/components/build_date_selector.dart'
    show DaysType;
import 'package:provider/provider.dart';

class BuildContainerDay extends StatelessWidget {
  final int index;
  final List<DaysType> daysList;
  final Function selectDate;
  final String? language;

  const BuildContainerDay({
    required this.index,
    required this.daysList,
    required this.selectDate,
    required this.language,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dateIndex = daysList[index];
    final String dayWeek = dateIndex.day ==
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            )
        ? 'Hoje'.toUpperCase() //TODO -> Should be provided from context.loc
        : DateFormat('E', language)
            .format(dateIndex.day)
            .replaceAll('.', '')
            .toUpperCase();

    return InkWell(
      onTap: () {
        removePreviousSelectedDay();
        dateIndex.isSelected = true;
        selectDate(dateIndex.day);
        context.read<ShoppingTicketCart>().updateDateCart(date: dateIndex.day);
      },
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 100,
        ),
        decoration: BoxDecoration(
          color:
              dateIndex.isSelected == true ? mainBlue : mainBlue.withAlpha(150),
          border: Border.all(
            color: secondBlue,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dayWeek,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              DateFormat('Md', language).format(dateIndex.day),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void removePreviousSelectedDay() {
    daysList.firstWhere((element) => element.isSelected == true).isSelected =
        false;
  }
}
