import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:museo/models/store/coupon.dart';
import 'package:museo/services/endpoints.dart';

class CouponService {
  Future getCouponByCode({required String code}) async {
    final response = await http.get(
      Api().coupon(endpoint: 'code/$code'),
    );

    if (response.statusCode != 200) {
      return null;
    }

    final body = jsonDecode(response.body)['coupon'];
    final coupon = CouponDiscount.fromJson(body);
    return coupon;
  }
}
