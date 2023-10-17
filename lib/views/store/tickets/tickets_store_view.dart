import 'package:flutter/material.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/providers/store/shopping_ticket_cart.dart';
import 'package:museo/views/store/tickets/components/build_date_selector.dart';
import 'package:museo/views/store/tickets/components/build_tickets_list.dart';
import 'package:museo/views/store/tickets/components/build_title_coupon_store.dart';
import 'package:museo/views/store/tickets/components/build_total_and_payment.dart';
import 'package:provider/provider.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  late DateTime selectedDate = DateTime.now();
  late ShoppingTicketCart _shoppingTicketCart;

  @override
  void initState() {
    _shoppingTicketCart =
        Provider.of<ShoppingTicketCart>(context, listen: false);
    // Initialize cart with nothing inside.
    _shoppingTicketCart.createEmptyCart();
    // Select the current time to initial cart when the user not select any date (BC the first one was selected by deafult).
    _shoppingTicketCart.cart.date = selectedDate;
    super.initState();
  }

  @override
  void dispose() {
    _shoppingTicketCart.clearCart();
    super.dispose();
  }

  void selectDate(DateTime day) {
    setState(() {
      selectedDate = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.store),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO -> This title shoul by provided by context.loc
          const BuildTitleCouponStore(title: 'Datas disponíveis'),
          const SizedBox(height: 40),
          BuildDateSelector(selectDate: selectDate),
          const BuildTicketsList(),
          const BuildTotalAndPayment(),
        ],
      ),
    );
  }
}
