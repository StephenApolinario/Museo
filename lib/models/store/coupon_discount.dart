enum CouponClassType {
  tickets,
  souvenirs,
}

enum CouponAcess {
  percentage,
  value,
}

class CouponDiscount {
  String code;
  CouponClassType type;
  CouponAcess access;
  double percentageDiscount, valueDiscount;

  CouponDiscount({
    required this.code,
    required this.type,
    required this.access,
    required this.percentageDiscount,
    required this.valueDiscount,
  });
}

List<CouponDiscount> fakeCouponDiscounts = [
  CouponDiscount(
    code: '10reais',
    type: CouponClassType.tickets,
    access: CouponAcess.value,
    percentageDiscount: 0,
    valueDiscount: 10,
  ),
  CouponDiscount(
    code: 'free',
    type: CouponClassType.tickets,
    access: CouponAcess.percentage,
    percentageDiscount: 100,
    valueDiscount: 0,
  ),
  CouponDiscount(
    code: '10%',
    type: CouponClassType.tickets,
    access: CouponAcess.percentage,
    percentageDiscount: 10,
    valueDiscount: 0,
  ),
];
