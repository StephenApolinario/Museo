import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/models/store/product.dart';

class Categories extends StatefulWidget {
  final int categorieIndex;
  final Function(int) updateIndex;

  const Categories({
    super.key,
    required this.categorieIndex,
    required this.updateIndex,
  });

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<SouvenirsCategory> categories = fakeSouvenirsList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategory(index),
        ),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        widget.updateIndex(index);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categories[index].name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: widget.categorieIndex == index
                    ? grayStoreColor
                    : lightGrayStoreColor,
              ),
            ),
            Container(
              height: 2,
              width: 30,
              color: widget.categorieIndex == index
                  ? Colors.black
                  : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}