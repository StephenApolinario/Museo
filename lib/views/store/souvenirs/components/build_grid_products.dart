import 'package:flutter/material.dart';
import 'package:museo/models/store/category_product.dart';
import 'package:museo/models/store/product.dart';
import 'package:museo/views/store/souvenirs/components/build_item_card.dart';
import 'package:museo/views/store/souvenirs/souvenirs_detail_view.dart';

class BuildGridProducts extends StatelessWidget {
  final SouvenirsCategory selectedCategory;
  final List<Product> products;

  const BuildGridProducts({
    super.key,
    required this.selectedCategory,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    final productsFromCategory = products
        .where((Product product) => product.category == selectedCategory.name)
        .toList();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
            itemCount: productsFromCategory.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              return BuildItemCard(
                product: productsFromCategory[index],
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SouvenirsDetailsView(
                      product: productsFromCategory[index],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
