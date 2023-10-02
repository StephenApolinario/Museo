import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/helpers/price.dart';
import 'package:museo/providers/shopping_ticket_cart.dart';
import 'package:provider/provider.dart';

class BuildTotalAndPayment extends StatelessWidget {
  const BuildTotalAndPayment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: mainBlue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              // TODO -> This text should be provided by L10N
              'Carrinho atual: ${generatePrice(price: context.watch<ShoppingTicketCart>().shoppingCartPrice())}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            // TODO -> Payment screen
            // TODO -> Check if the user is loggin. If not, show some message.
            TextButton(
              onPressed: () {
                print(Provider.of<ShoppingTicketCart>(context, listen: false)
                    .cart
                    .tickets);
                print(Provider.of<ShoppingTicketCart>(context, listen: false)
                    .cart
                    .date);
                return;
              },
              child: const Text('Pagar'),
            ),
          ],
        ),
      ),
    );
  }
}
