import 'package:flutter/material.dart';
import 'package:museo/providers/shopping_ticket_cart.dart';
import 'package:museo/views/store/checkout/components/build_cart_summary_title.dart';
import 'package:museo/views/store/checkout/components/build_cart_summary_details.dart';
import 'package:museo/views/store/checkout/components/build_coupon_code.dart';
import 'package:museo/views/store/checkout/components/build_hello_user.dart';
import 'package:museo/views/store/checkout/components/build_location_address.dart';
import 'package:museo/views/store/checkout/components/build_payment_information.dart';
import 'package:museo/views/store/checkout/components/build_payment_method.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ShoppingTicketCart providerTicket =
        context.watch<ShoppingTicketCart>();

    return Scaffold(
      appBar: AppBar(
        // TODO -> This text must be provided by the L10N
        title: const Text('CHECKOUT'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary order on top of the user image.
              const Stack(
                children: [
                  BuildHelloUser(),
                  BuildCartSummaryTitle(),
                ],
              ),
              BuildCartSummaryDetails(providerTicket: providerTicket),
              BuildLocationAddress(providerTicket: providerTicket),
              BuildPaymentMethod(providerTicket: providerTicket),
              BuildCouponCode(providerTicket: providerTicket),
              const BuildPaymentInformation(),
            ],
          ),
        ),
      ),
    );
  }
}
