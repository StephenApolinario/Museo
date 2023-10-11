import 'package:flutter/material.dart' show Icon, Icons;
import 'package:museo/constants/colors.dart';

class PaymentMethod {
  int id;
  String name;
  Icon icon;
  double feesPrice;
  double feePercentage;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.icon,
    required this.feePercentage,
    required this.feesPrice,
  });
}

class ExtraPaymentMethods {
  String text;

  ExtraPaymentMethods({
    required this.text,
  });
}

List<ExtraPaymentMethods> fakeExtraPaymentMethods = [
  ExtraPaymentMethods(
    text: 'Depósito bancário',
  ),
  ExtraPaymentMethods(
    text: 'Transferência bancária',
  ),
  ExtraPaymentMethods(
    text: 'Depósito',
  ),
];

List<PaymentMethod> fakePaymentMethods = [
  PaymentMethod(
    id: 1,
    name: 'Cartão de crédtio',
    icon: const Icon(
      Icons.credit_card,
      color: mainBlue,
      size: 30,
    ),
    feePercentage: 2,
    feesPrice: 0,
  ),
  PaymentMethod(
    id: 2,
    name: 'Cartão de débito',
    icon: const Icon(
      Icons.credit_card,
      color: mainBlue,
      size: 30,
    ),
    feePercentage: 0,
    feesPrice: 0,
  ),
  PaymentMethod(
    id: 3,
    name: 'Google Pay',
    icon: const Icon(
      Icons.credit_card,
      color: mainBlue,
      size: 30,
    ),
    feePercentage: 0,
    feesPrice: 0,
  ),
  PaymentMethod(
    id: 4,
    name: 'Paypal',
    icon: const Icon(
      Icons.credit_card,
      color: mainBlue,
      size: 30,
    ),
    feePercentage: 2,
    feesPrice: 2.5,
  ),
];
