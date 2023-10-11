import 'package:museo/models/store/coupon_discount.dart';

class Ticket {
  final int id;
  final String title, subtitle, description;
  final double price;

  Ticket({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.price,
  });
}

class TicketsCart {
  final int id;
  final String name;
  int quantity;
  double price;

  TicketsCart({
    required this.id,
    required this.quantity,
    required this.name,
    required this.price,
  });
}

class ShoppingTicketsCart {
  late DateTime? date;
  late List<TicketsCart> tickets = [];
  late bool isCouponApplied = false;
  late double totalPriceBeforeDiscount = 0;
  late double totalPriceAfterDiscount = 0;
  late CouponDiscount coupon;

  ShoppingTicketsCart({
    required this.tickets,
    this.date,
  });
}

List<Ticket> fakeTickets = [
  Ticket(
    id: 1,
    title: 'Ingresso Inteira',
    subtitle: 'Visita não guiada ao Museu Oceanográfico Univali',
    description:
        'Ingresso destinado às pessoas que NÃO se enquadram na política de meia-entrada.\n\nGrupos escolares, de professores, de acadêmicos, turísticos, podem agendar visitas guiadas, desde que com um número mínimo de 10 pessoas. A visita será acompanhada por mediadores que apresentam a exposição permanente do museu, destacando os principais exemplares. Esta atividade é realizada por profissionais que atuam no setor educativo do museu, bem como por estagiários acadêmicos da Univali que recebem formação para desenvolver tal atividade.',
    price: 30.00,
  ),
  Ticket(
    id: 2,
    title: 'Pacote Educativo 1',
    subtitle:
        'Visita Mediada + Ceantar, + Laboratório + Visita ténica as coleções e laboratórios',
    description:
        'Grupos escolares, de professores, de acadêmicos, turísticos, podem agendar visitas guiadas, desde que com um número mínimo de 10 pessoas. A visita será acompanhada por mediadores que apresentam a exposição permanente do museu, destacando os principais exemplares. Esta atividade é realizada por profissionais que atuam no setor educativo do museu, bem como por estagiários acadêmicos da Univali que recebem formação para desenvolver tal atividade.',
    price: 15.00,
  ),
  Ticket(
    id: 3,
    title: 'Pacote Educativo 2',
    subtitle:
        'Visita Mediada + Ceantar, + Laboratório + Visita ténica as coleções e laboratórios',
    description:
        'Grupos escolares, de professores, de acadêmicos, turísticos, podem agendar visitas guiadas, desde que com um número mínimo de 10 pessoas. A visita será acompanhada por mediadores que apresentam a exposição permanente do museu, destacando os principais exemplares. Esta atividade é realizada por profissionais que atuam no setor educativo do museu, bem como por estagiários acadêmicos da Univali que recebem formação para desenvolver tal atividade.',
    price: 15.00,
  ),
  Ticket(
    id: 4,
    title: 'Pacote Educativo 3',
    subtitle:
        'Visita Mediada + Ceantar, + Laboratório + Visita ténica as coleções e laboratórios',
    description:
        'Grupos escolares, de professores, de acadêmicos, turísticos, podem agendar visitas guiadas, desde que com um número mínimo de 10 pessoas. A visita será acompanhada por mediadores que apresentam a exposição permanente do museu, destacando os principais exemplares. Esta atividade é realizada por profissionais que atuam no setor educativo do museu, bem como por estagiários acadêmicos da Univali que recebem formação para desenvolver tal atividade.',
    price: 15.00,
  ),
  Ticket(
    id: 4,
    title: 'Pacote da luana',
    subtitle:
        'Visita Mediada + Ceantar, + Laboratório + Visita ténica as coleções e laboratórios',
    description:
        'Grupos escolares, de professores, de acadêmicos, turísticos, podem agendar visitas guiadas, desde que com um número mínimo de 10 pessoas. A visita será acompanhada por mediadores que apresentam a exposição permanente do museu, destacando os principais exemplares. Esta atividade é realizada por profissionais que atuam no setor educativo do museu, bem como por estagiários acadêmicos da Univali que recebem formação para desenvolver tal atividade.',
    price: 10.00,
  ),
];
