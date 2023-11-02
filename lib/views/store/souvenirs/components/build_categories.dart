import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/string.dart';
import 'package:museo/models/store/category_product.dart';

class BuildCategories extends StatefulWidget {
  final SouvenirsCategory selectedCategory;

  final List<SouvenirsCategory> categorys;
  final Function(SouvenirsCategory) updateCategory;

  const BuildCategories({
    super.key,
    required this.categorys,
    required this.updateCategory,
    required this.selectedCategory,
  });

  @override
  State<BuildCategories> createState() => _BuildCategoriesState();
}

class _BuildCategoriesState extends State<BuildCategories> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.categorys.length,
          itemBuilder: (context, index) => buildCategory(index),
        ),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        widget.updateCategory(widget.categorys[index]);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.categorys[index].name.toCapitalized(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: widget.selectedCategory == widget.categorys[index]
                    ? grayStoreColor
                    : lightGrayStoreColor,
              ),
            ),
            Container(
              height: 2,
              width: 30,
              color: widget.selectedCategory == widget.categorys[index]
                  ? Colors.black
                  : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
