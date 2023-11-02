import 'package:museo/models/store/coupon.dart';

class TicketsCart {
  final String id;
  final String name;
  int quantity;
  double price;

  TicketsCart({
    required this.id,
    required this.quantity,
    required this.name,
    required this.price,
  });
}

class ShoppingTicketsCart {
  late DateTime? date;
  late List<TicketsCart> tickets = [];
  late bool isCouponApplied = false;
  late double totalPriceBeforeDiscount = 0;
  late double totalPriceAfterDiscount = 0;
  late CouponDiscount coupon;

  ShoppingTicketsCart({
    required this.tickets,
    this.date,
  });
}

class NewTicket {
  final String id;
  final String name;
  final String subname;
  final String description;
  final double price;

  NewTicket({
    required this.id,
    required this.name,
    required this.subname,
    required this.description,
    required this.price,
  });

  factory NewTicket.fromJson(Map<String, dynamic> json) {
    return NewTicket(
      id: json['_id'],
      name: json['name'],
      subname: json['subname'],
      description: json['description'],
      price: json['price'].toDouble(),
    );
  }
}
