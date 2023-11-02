import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:museo/models/store/category_product.dart';
import 'package:museo/models/store/product.dart';
import 'package:museo/services/endpoints.dart';

class SouvenirsService {
  Future getProductCategory() async {
    final response = await http.get(
      Api().productCategory(endpoint: ''),
    );

    if (response.statusCode != 200) {
      return null;
    }

    final categorys = jsonDecode(response.body)['categorys'];
    List<SouvenirsCategory> categoryList = (categorys as List).map((category) {
      return SouvenirsCategory.fromJson(category);
    }).toList();
    return categoryList;
  }

  Future getProduct() async {
    final response = await http.get(
      Api().product(endpoint: ''),
    );

    if (response.statusCode != 200) {
      return null;
    }

    final product = jsonDecode(response.body)['products'];
    List<Product> productList = (product as List).map((category) {
      return Product.fromJson(category);
    }).toList();
    return productList;
  }
}
