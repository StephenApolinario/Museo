enum CouponType {
  tickets,
  souvenirs,
}

enum CouponAcess {
  percentage,
  value,
}

class CouponDiscount {
  String code;
  List<CouponType> type;
  List<CouponAcess> access;
  double percentageDiscount, valueDiscount;

  CouponDiscount({
    required this.code,
    required this.type,
    required this.access,
    required this.percentageDiscount,
    required this.valueDiscount,
  });

  factory CouponDiscount.fromJson(Map<String, dynamic> json) {
    var typeData = json['type'] as List<dynamic>;
    var accessData = json['access'] as List<dynamic>;

    var typeEnums = typeData.map((typesFromJson) {
      return CouponType.values.firstWhere(
        (element) =>
            element.toString().split('.').last == typesFromJson['type'],
      );
    }).toList();

    var accessEnums = accessData.map((accessFromJson) {
      return CouponAcess.values.firstWhere(
        (element) =>
            element.toString().split('.').last == accessFromJson['access'],
      );
    }).toList();

    return CouponDiscount(
      code: json['code'],
      type: typeEnums,
      access: accessEnums,
      percentageDiscount: json['percentage'].toDouble(),
      valueDiscount: json['value'].toDouble(),
    );
  }
}
