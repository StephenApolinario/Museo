import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/gen/assets.gen.dart';
import 'package:museo/models/store/tickets.dart';
import 'package:museo/providers/store/shopping_ticket_cart.dart';
import 'package:museo/services/ticket_service.dart';
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
  late ShoppingTicketCart _shoppingTicketCart;

  @override
  void initState() {
    _shoppingTicketCart =
        Provider.of<ShoppingTicketCart>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TicketService().getTickets(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Initialize cart with nothing inside.
          _shoppingTicketCart.updateTickets(snapshot.data);
          _shoppingTicketCart.createEmptyCart();
          return Expanded(
            child: ListView.builder(
              itemCount: (snapshot.data as List<NewTicket>).length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return TicketBuilder(
                  ticket: (snapshot.data as List<NewTicket>)[index],
                );
              },
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class TicketBuilder extends StatefulWidget {
  final NewTicket ticket;

  const TicketBuilder({
    super.key,
    required this.ticket,
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
          LeftSideTicket(ticket: widget.ticket),
          RightSideTicket(
            ticket: widget.ticket,
          ),
        ],
      ),
    );
  }
}

class LeftSideTicket extends StatelessWidget {
  final NewTicket ticket;

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
  final NewTicket ticket;

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
  final NewTicket ticket;

  const RightSideTicket({
    super.key,
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
        children: [
          buildOutlinedButton(
            icon: Icons.add,
            press: () {
              setState(() {
                numOfItems++;
              });
              _shoppingTicketCart.updateCart(
                newQuantity: numOfItems,
                ticketID: widget.ticket.id,
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
                ticketID: widget.ticket.id,
              );
            },
          ),
        ],
      ),
    );
  }
}

class MoreInformation extends StatelessWidget {
  final NewTicket ticket;
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
          child: Row(
            children: [
              const Icon(
                Icons.info,
                color: mainBlue,
                size: 24,
              ),
              Text(context.loc.more_information),
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

  final NewTicket ticket;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: Text(
        ticket.subname,
        textAlign: TextAlign.justify,
      ),
    );
  }
}

class TicketTitle extends StatelessWidget {
  final NewTicket ticket;

  const TicketTitle({
    super.key,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 50),
      child: Text(
        ticket.name,
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
