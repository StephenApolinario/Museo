import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/models/store/product.dart';

class ColorAndSize extends StatelessWidget {
  const ColorAndSize({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Color',
                style: TextStyle(
                  color: grayStoreColor,
                ),
              ),
              Row(
                children: [
                  ColorDot(
                    color: product.color,
                    isSelected: true,
                  ),
                  const ColorDot(
                    color: Colors.red,
                  ),
                  const ColorDot(
                    color: Colors.yellow,
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: grayStoreColor,
              ),
              children: [
                const TextSpan(
                  text: 'Size\n',
                ),
                TextSpan(
                  text: '${product.size} cm',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ColorDot extends StatelessWidget {
  final Color color;
  final bool isSelected;
  const ColorDot({
    super.key,
    required this.color,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 5,
        right: 10,
      ),
      padding: const EdgeInsets.all(2.5),
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? color : Colors.transparent,
        ),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
