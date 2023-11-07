import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/helpers/price.dart';
import 'package:museo/models/museum_information.dart';
import 'package:museo/models/store/tickets.dart';
import 'package:museo/services/museum_information_service.dart';

class CouponsDetailsView extends StatelessWidget {
  final NewTicket ticket;

  const CouponsDetailsView({
    super.key,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    final parentContex = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.store),
      ),
      body: FutureBuilder(
        future: MuseumInformationService().getMuseumInformation(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TicketDetails(
                        ticket: ticket,
                      ),
                      MuseumDetails(
                        museumInformation: snapshot.data,
                        parentContex: parentContex,
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: mainBlue,
              ),
            );
          }
        },
      ),
    );
  }
}

class MuseumDetails extends StatelessWidget {
  final BuildContext parentContex;
  final MuseumInformation museumInformation;

  const MuseumDetails({
    super.key,
    required this.museumInformation,
    required this.parentContex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BlueDivider(height: 35, top: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              buildOfficeHour(parentContex),
              buildContact(parentContex),
              buildPhoneNumber(parentContex),
              buildInstagram(parentContex),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildOfficeHour(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.watch_later_outlined),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(
              left: 5,
              top: 15,
            ),
            child: Text(
              'Expediente: Segunda a sexta-feira das 08h às 12h e das 13h30 às 17h30',
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildInstagram(BuildContext context) {
    return Row(
      children: [
        const FaIcon(FontAwesomeIcons.instagram),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 5,
              top: 15,
              bottom: 15,
            ),
            child: Text(
              '@${museumInformation.instagram}',
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPhoneNumber(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.phone_outlined),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 5,
              top: 15,
            ),
            child: Text(
              '${context.loc.phone}: ${museumInformation.phoneList[0].phoneNumber}',
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildContact(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.email_outlined),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 5,
              top: 15,
            ),
            child: Text(
              '${context.loc.email_contact} ${museumInformation.emailList[0].email}',
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ],
    );
  }
}

class TicketDetails extends StatelessWidget {
  final NewTicket ticket;

  const TicketDetails({
    super.key,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title
          Center(
            child: Text(
              ticket.name,
              style: const TextStyle(
                color: mainBlue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 30),
          // Subtitle
          Text(
            ticket.subname,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: mainBlue,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            '${context.loc.price} ${generatePrice(price: ticket.price)}',
            style: const TextStyle(
              color: mainBlue,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Description
          const SizedBox(height: 40),
          Text(
            ticket.description,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class BlueDivider extends StatelessWidget {
  final double top, bottom, left, right, height;

  const BlueDivider({
    super.key,
    this.top = 0,
    this.bottom = 0,
    this.left = 0,
    this.right = 0,
    this.height = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: bottom,
        left: left,
        right: right,
        top: top,
      ),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: mainBlue,
        ),
      ),
    );
  }
}
