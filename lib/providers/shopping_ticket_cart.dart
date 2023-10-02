import 'package:flutter/material.dart';
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
          quantity: 0,
        ),
      );
    }
  }

  void updateCart({required int newQuantity, required int ticketID}) {
    cart.tickets.firstWhere((ticket) => ticket.id == ticketID).quantity =
        newQuantity;
    notifyListeners();
  }

  void updateDateCart({required DateTime date}) {
    cart.date = date;
    notifyListeners();
  }

  double shoppingCartPrice() {
    double price = 0;
    for (var ticket in cart.tickets) {
      price += ticket.quantity *
          fakeTickets.firstWhere((element) => ticket.id == element.id).price;
    }
    return price;
  }
}
