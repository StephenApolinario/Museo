import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/models/store/products.dart';

class BuildItemCard extends StatelessWidget {
  final Product product;
  final Function() press;

  const BuildItemCard({
    super.key,
    required this.product,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: product.color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: '${product.id}',
                child: Image.asset(product.image),
              ),
            ),
          ),
          Text(
            product.title,
            style: const TextStyle(
              color: lightGrayStoreColor,
            ),
          ),
          Text(
            '\$${product.price}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
