import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/providers/store/shopping_ticket_cart.dart';
import 'package:museo/services/coupon_service.dart';
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.discount,
              color: Colors.white,
              size: 25,
            ),
            Text(
              context.loc.discount_coupon,
              style: const TextStyle(
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
            isCouponApplied
                ? context.loc.remove_coupon
                : context.loc.apply_coupon,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
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
        decoration: InputDecoration(
          hintText: context.loc.coupon_code,
          contentPadding: const EdgeInsets.only(left: 4),
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> checkCoupon({required String code}) async {
    final coupon = await CouponService().getCouponByCode(code: code);
    bool discountExist = coupon != null ? true : false;
    if (discountExist) {
      widget.providerTicket.applyDiscount(
        coupon: coupon,
      );
    }
    return discountExist;
  }

  customOnPressed() async {
    if (_coupon.text.isEmpty) {
      return;
    }
    switch (widget.providerTicket.cart.isCouponApplied) {
      case false:
        bool exists = await checkCoupon(code: _coupon.text);
        if (!exists && context.mounted) {
          return showGenericDialog(
            context: context,
            title: context.loc.dialog_error_ops,
            content: context.loc.coupon_not_exists,
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
