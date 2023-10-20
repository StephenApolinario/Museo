import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/helpers/price.dart';
import 'package:museo/models/store/payments_methods.dart';
import 'package:museo/providers/store/shopping_ticket_cart.dart';

class BuildPaymentMethod extends StatelessWidget {
  final ShoppingTicketCart providerTicket;

  const BuildPaymentMethod({
    super.key,
    required this.providerTicket,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Column(
        children: [
          title(),
          const SizedBox(height: 5),
          options(),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget title() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: mainBlue,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.credit_card_outlined,
              color: Colors.white,
              size: 30,
            ),
            // TODO:  This text MUST be provided by L10N
            Text(
              'Formas de pagamento',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget options() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: fakePaymentMethods.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        PaymentMethod method = fakePaymentMethods[index];
        return Column(
          children: [
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: mainBlue),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          method.icon,
                          Text(method.name),
                        ],
                      ),
                      Text(
                        generatePrice(
                          price: priceAfterPaymentMethod(
                            value: providerTicket.cart.isCouponApplied
                                ? providerTicket.cart.totalPriceAfterDiscount
                                : providerTicket.cart.totalPriceBeforeDiscount,
                            method: method,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: mainBlue,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
