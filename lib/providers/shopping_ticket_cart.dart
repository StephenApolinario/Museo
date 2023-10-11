import 'package:flutter/material.dart';
import 'package:museo/models/store/coupon_discount.dart';
import 'package:museo/models/store/tickets.dart';

class ShoppingTicketCart with ChangeNotifier {
  late ShoppingTicketsCart cart = ShoppingTicketsCart(tickets: []);

  void clearCart() {
    cart = ShoppingTicketsCart(tickets: []);
  }

  void createEmptyCart() {
    for (var ticket in fakeTickets) {
      cart.tickets.add(
        TicketsCart(
          id: ticket.id,
          name: ticket.title,
          price: ticket.price,
          quantity: 0,
        ),
      );
    }
  }

  void updateCart({required int newQuantity, required int ticketID}) {
    cart.tickets.firstWhere((ticket) => ticket.id == ticketID).quantity =
        newQuantity;
    shoppingCartPrice();
  }

  void updateDateCart({required DateTime date}) {
    cart.date = date;
    notifyListeners();
  }

  void shoppingCartPrice() {
    double price = 0;
    for (var ticket in cart.tickets) {
      price += ticket.quantity *
          fakeTickets.firstWhere((element) => ticket.id == element.id).price;
    }
    cart.totalPriceBeforeDiscount = price;
    notifyListeners();
  }

  bool anyTicket() {
    bool isTicket = cart.tickets.any(
      (ticket) => ticket.quantity > 0,
    );
    return isTicket;
  }

  void applyDiscount({
    required CouponDiscount coupon,
  }) {
    late double newTotalPrice;
    const double minimumPrice = 1;
    switch (coupon.access) {
      case CouponAcess.value:
        newTotalPrice = cart.totalPriceBeforeDiscount - coupon.valueDiscount;
      case CouponAcess.percentage:
        newTotalPrice = cart.totalPriceBeforeDiscount -
            (cart.totalPriceBeforeDiscount * coupon.percentageDiscount / 100);
      default:
        throw Exception('Discount doens\'t have any type');
    }
    cart.isCouponApplied = true;
    cart.coupon = coupon;
    cart.totalPriceAfterDiscount =
        newTotalPrice == 0 ? minimumPrice : newTotalPrice;
    notifyListeners();
  }

  void removeDiscount() {
    cart.isCouponApplied = false;
    notifyListeners();
  }
}
