import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/models/museum_information.dart';
import 'package:museo/providers/store/shopping_ticket_cart.dart';

class BuildLocationAddress extends StatelessWidget {
  final ShoppingTicketCart providerTicket;
  final MuseumInformation museumInformation;

  const BuildLocationAddress({
    super.key,
    required this.providerTicket,
    required this.museumInformation,
  });

  @override
  Widget build(BuildContext context) {
    final String? language =
        Localizations.maybeLocaleOf(context)?.toLanguageTag();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          buildBlueDivider(),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${museumInformation.city} - ${museumInformation.state}'),
                  Text(
                    '${context.loc.data}: ${DateFormat('yMd', language).format(providerTicket.cart.date!).toUpperCase()}',
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          buildBlueDivider(),
        ],
      ),
    );
  }

  Widget buildBlueDivider() {
    return Container(
      height: 1.5,
      color: mainBlue,
    );
  }
}
