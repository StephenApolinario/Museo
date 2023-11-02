import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/helpers/price.dart';
import 'package:museo/models/store/tickets.dart';

class CouponsDetailsView extends StatelessWidget {
  final NewTicket ticket;

  const CouponsDetailsView({
    super.key,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.store),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TicketDetails(ticket: ticket),
                const MuseumDetails(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MuseumDetails extends StatelessWidget {
  const MuseumDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        BlueDivider(height: 35, top: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              BuildOfficeHour(),
              BuildContact(),
              BuildPhoneNumber(),
              BuildInstagram(),
            ],
          ),
        ),
      ],
    );
  }
}

class BuildInstagram extends StatelessWidget {
  const BuildInstagram({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        // TODO:  INSTAGRAM icon
        Icon(Icons.construction),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(
              left: 5,
              top: 15,
              bottom: 15,
            ),
            child: Text(
              '@museuoceanografico',
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ],
    );
  }
}

class BuildPhoneNumber extends StatelessWidget {
  const BuildPhoneNumber({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.phone_outlined),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(
              left: 5,
              top: 15,
            ),
            child: Text(
              'Telefone: +55 (47) 3261-1402',
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ],
    );
  }
}

class BuildContact extends StatelessWidget {
  const BuildContact({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.email_outlined),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(
              left: 5,
              top: 15,
            ),
            child: Text(
              'Para contato e agendamento envie e-mail para educaco.movi@univali.br',
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ],
    );
  }
}

class BuildOfficeHour extends StatelessWidget {
  const BuildOfficeHour({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
