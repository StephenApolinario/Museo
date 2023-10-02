import 'package:intl/intl.dart';

String generatePrice({
  required double price,
}) {
  final String priceText = NumberFormat.simpleCurrency(
    locale: 'pt-br',
    decimalDigits: 2,
  ).format(price);
  return priceText;
}
