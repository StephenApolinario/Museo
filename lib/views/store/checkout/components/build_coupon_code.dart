import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/models/store/coupon_discount.dart';
import 'package:museo/providers/store/shopping_ticket_cart.dart';
import 'package:museo/utilities/dialogs/generic_dialog.dart';

class BuildCouponCode extends StatefulWidget {
  final ShoppingTicketCart providerTicket;

  const BuildCouponCode({
    super.key,
    required this.providerTicket,
  });

  @override
  State<BuildCouponCode> createState() => _BuildCouponCodeState();
}

class _BuildCouponCodeState extends State<BuildCouponCode> {
  late final TextEditingController _coupon;

  @override
  void initState() {
    _coupon = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _coupon.dispose();
    widget.providerTicket.cart.isCouponApplied = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, top: 5),
      child: Column(
        children: [
          title(),
          inputWithButton(),
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
              Icons.discount,
              color: Colors.white,
              size: 25,
            ),
            // TODO:  This text MUST be provided by L10N
            Text(
              'Cupom de desconto',
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

  Widget inputWithButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: mainBlue),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              couponTextField(),
              const SizedBox(width: 10),
              couponApplyButton()
            ],
          ),
        ),
      ),
    );
  }

  ValueListenableBuilder<TextEditingValue> couponApplyButton() {
    bool isCouponApplied = widget.providerTicket.cart.isCouponApplied;
    return ValueListenableBuilder(
      valueListenable: _coupon,
      builder: (context, value, child) {
        return ElevatedButton(
          onPressed: customOnPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(mainBlue),
          ),
          child: Text(
            isCouponApplied ? 'Remover' : 'Aplicar',
            style: const TextStyle(
              color: Colors.white,
            ),
          ), // TODO:  This MUST be provided by L10N
        );
      },
    );
  }

  Expanded couponTextField() {
    return Expanded(
      child: TextField(
        controller: _coupon,
        enabled: widget.providerTicket.cart.isCouponApplied ? false : true,
        enableSuggestions: false,
        autocorrect: false,
        decoration: const InputDecoration(
          hintText: 'Código de cupom', //Must be provided by L10N
          contentPadding: EdgeInsets.only(left: 4),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
        ),
      ),
    );
  }

  checkCoupon({required String code}) {
    bool discountExist = fakeCouponDiscounts.any(
      (coupon) => coupon.code == code,
    );
    if (discountExist) {
      widget.providerTicket.applyDiscount(
        coupon: fakeCouponDiscounts.firstWhere((coupon) => coupon.code == code),
      );
    }
    return discountExist;
  }

  customOnPressed() {
    if (_coupon.text.isEmpty) {
      return;
    }
    switch (widget.providerTicket.cart.isCouponApplied) {
      case false:
        if (!checkCoupon(code: _coupon.text)) {
          return showGenericDialog(
            context: context,
            title: context.loc.dialog_error_ops,
            content:
                'Esse cupom de desconto não existe!', //TODO:  This MUST be provided by L10N
            optionsBuilder: () => {
              'Ok': false,
            },
          );
        }
        break;
      case true:
        widget.providerTicket.removeDiscount();
      default:
        throw Exception('ERROR!');
    }
  }
}
