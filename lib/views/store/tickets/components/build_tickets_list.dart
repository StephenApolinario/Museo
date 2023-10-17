import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/gen/assets.gen.dart';
import 'package:museo/models/store/tickets.dart';
import 'package:museo/providers/store/shopping_ticket_cart.dart';
import 'package:museo/views/store/components/build_outilned_button.dart';
import 'package:museo/views/store/tickets/tickets_details_view.dart';
import 'package:museo/helpers/price.dart';
import 'package:provider/provider.dart';

class BuildTicketsList extends StatefulWidget {
  const BuildTicketsList({
    super.key,
  });

  @override
  State<BuildTicketsList> createState() => _BuildTicketsListState();
}

class _BuildTicketsListState extends State<BuildTicketsList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: fakeTickets.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return TicketBuilder(index: index);
        },
      ),
    );
  }
}

class TicketBuilder extends StatefulWidget {
  final int index;

  const TicketBuilder({
    super.key,
    required this.index,
  });

  @override
  State<TicketBuilder> createState() => _TicketBuilderState();
}

class _TicketBuilderState extends State<TicketBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      width: 100,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          image: AssetImage(
            Assets.store.images.tickets.ticket.path,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        children: [
          LeftSideTicket(ticket: fakeTickets[widget.index]),
          RightSideTicket(
            ticket: fakeTickets[widget.index],
            index: widget.index,
          ),
        ],
      ),
    );
  }
}

class LeftSideTicket extends StatelessWidget {
  final Ticket ticket;

  const LeftSideTicket({
    super.key,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO -> This title & Subtitle should be provided by the API
          TicketTitle(ticket: ticket),
          Price(ticket: ticket),
          TicketSubtitle(ticket: ticket),
          MoreInformation(ticket: ticket),
        ],
      ),
    );
  }
}

class Price extends StatelessWidget {
  final Ticket ticket;

  const Price({
    super.key,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Text(
        'Valor: ${generatePrice(
          price: ticket.price,
        )}',
        style: const TextStyle(
          color: mainBlue,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class RightSideTicket extends StatefulWidget {
  final Ticket ticket;
  final int index;

  const RightSideTicket({
    super.key,
    required this.index,
    required this.ticket,
  });

  @override
  State<RightSideTicket> createState() => _RightSideTicketState();
}

class _RightSideTicketState extends State<RightSideTicket> {
  int numOfItems = 0;
  late ShoppingTicketCart _shoppingTicketCart;

  @override
  void initState() {
    _shoppingTicketCart =
        Provider.of<ShoppingTicketCart>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildOutlinedButton(
            icon: Icons.add,
            press: () {
              setState(() {
                numOfItems++;
              });
              _shoppingTicketCart.updateCart(
                newQuantity: numOfItems,
                ticketID: fakeTickets[widget.index].id,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              numOfItems.toString().padLeft(2, '0'),
              style: const TextStyle(
                color: grayStoreColor,
                fontSize: 18,
              ),
            ),
          ),
          buildOutlinedButton(
            icon: Icons.remove,
            press: () {
              setState(() {
                if (numOfItems > 0) {
                  setState(() {
                    numOfItems--;
                  });
                }
              });
              _shoppingTicketCart.updateCart(
                newQuantity: numOfItems,
                ticketID: fakeTickets[widget.index].id,
              );
            },
          ),
        ],
      ),
    );
  }
}

class MoreInformation extends StatelessWidget {
  final Ticket ticket;
  const MoreInformation({
    super.key,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CouponsDetailsView(ticket: ticket),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
          ),
          child: const Row(
            children: [
              Icon(
                Icons.info,
                color: mainBlue,
                size: 24,
              ),
              // TODO -> This should be provided by context.loc
              Text('Mais informações'),
            ],
          ),
        ),
      ],
    );
  }
}

class TicketSubtitle extends StatelessWidget {
  const TicketSubtitle({
    super.key,
    required this.ticket,
  });

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: Text(
        ticket.subtitle,
        textAlign: TextAlign.justify,
      ),
    );
  }
}

class TicketTitle extends StatelessWidget {
  final Ticket ticket;
  const TicketTitle({
    super.key,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 50),
      child: Text(
        ticket.title,
        textAlign: TextAlign.justify,
        style: const TextStyle(
          color: mainBlue,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
