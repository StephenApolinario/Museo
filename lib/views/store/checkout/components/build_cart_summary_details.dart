import 'package:flutter/material.dart';
import 'package:museo/helpers/price.dart';
import 'package:museo/providers/store/shopping_ticket_cart.dart';
import 'package:provider/provider.dart';

class BuildCartSummaryDetails extends StatelessWidget {
  final ShoppingTicketCart providerTicket;

  const BuildCartSummaryDetails({
    super.key,
    required this.providerTicket,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildTickets(providerTicket: providerTicket),
          // TODO:  Another row for the souvenirs
          BuildTotalCart(providerTicket: providerTicket),
        ],
      ),
    );
  }
}

class BuildTotalCart extends StatelessWidget {
  final ShoppingTicketCart providerTicket;

  const BuildTotalCart({
    super.key,
    required this.providerTicket,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        // TODO:  MUST be provided by L10N
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'TOTAL',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: [
                Text(
                  generatePrice(
                      price: providerTicket.cart.totalPriceBeforeDiscount),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    decoration: providerTicket.cart.isCouponApplied
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                providerTicket.cart.isCouponApplied
                    ? Text(
                        generatePrice(
                          price: providerTicket.cart.totalPriceAfterDiscount,
                        ),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class BuildTickets extends StatelessWidget {
  final ShoppingTicketCart providerTicket;

  const BuildTickets({
    super.key,
    required this.providerTicket,
  });

  @override
  Widget build(BuildContext context) {
    // If there is any ticket return the total tickets
    // If doenst have any ticket, just return the SizedBox.shrink() -> Nothing
    return Provider.of<ShoppingTicketCart>(context, listen: false).anyTicket()
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ingresso(s):',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              BuilderTicketsList(providerTicket: providerTicket),
            ],
          )
        : const SizedBox.shrink();
  }
}

class BuilderTicketsList extends StatelessWidget {
  final ShoppingTicketCart providerTicket;

  const BuilderTicketsList({
    super.key,
    required this.providerTicket,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: providerTicket.cart.tickets.map(
        (ticket) {
          return ticket.quantity > 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // ticketsList.toUpperCase(),
                      '${ticket.quantity.toString().padLeft(2, '0')} ${ticket.name.toUpperCase()}',
                    ),
                    Text(
                      generatePrice(price: ticket.price * ticket.quantity),
                    ),
                  ],
                )
              : const SizedBox.shrink();
        },
      ).toList(),
    );
  }
}
