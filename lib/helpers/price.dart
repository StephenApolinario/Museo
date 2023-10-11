import 'package:intl/intl.dart';
import 'package:museo/models/store/payments_methods.dart';

String generatePrice({
  required double price,
}) {
  final String priceText = NumberFormat.simpleCurrency(
    locale: 'pt-br',
    decimalDigits: 2,
  ).format(price);
  return priceText;
}

double priceAfterPaymentMethod({
  required double value,
  required PaymentMethod method,
}) {
  return (value + method.feesPrice) * (1 + method.feePercentage / 100);
}
