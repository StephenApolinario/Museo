import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/string.dart';
import 'package:museo/helpers/price.dart';
import 'package:museo/models/store/product.dart';
import 'package:shimmer/shimmer.dart';

Color getContrastingColor(Color color) {
  final double relativeLuminance = color.computeLuminance();
  return relativeLuminance > 0.5 ? Colors.black : Colors.white;
}

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
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: product.color.fromHex(),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: '${product.id}',
                child: Image.network(
                  product.image,
                  loadingBuilder: (
                    BuildContext context,
                    Widget child,
                    ImageChunkEvent? loadingProgress,
                  ) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: Shimmer.fromColors(
                          baseColor: product.color.fromHex(),
                          highlightColor: getContrastingColor(
                            product.color.fromHex(),
                          ),
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                  },
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const Center(
                      child: Text('Failed to load image'),
                    );
                  },
                ),
              ),
            ),
          ),
          Text(
            product.name,
            style: const TextStyle(
              color: lightGrayStoreColor,
            ),
          ),
          Text(
            generatePrice(price: product.price),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
