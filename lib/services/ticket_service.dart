import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:museo/models/store/tickets.dart';
import 'package:museo/services/endpoints.dart';

class TicketService {
  Future getTickets() async {
    final response = await http.get(
      Api().ticket(endpoint: ''),
    );

    if (response.statusCode != 200) {
      return null;
    }

    final tickets = jsonDecode(response.body)['tickets'];
    List<NewTicket> ticketList = (tickets as List).map((ticket) {
      return NewTicket.fromJson(ticket);
    }).toList();
    return ticketList;
  }
}
