import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/gen/assets.gen.dart';
import 'package:museo/views/store/souvenirs/components/build_categories.dart';
import 'package:museo/views/store/souvenirs/components/build_grid_products.dart';

class SouvenirsStoreView extends StatefulWidget {
  const SouvenirsStoreView({
    super.key,
  });

  @override
  State<SouvenirsStoreView> createState() => _SouvenirsStoreViewState();
}

class _SouvenirsStoreViewState extends State<SouvenirsStoreView> {
  int categorieIndex = 0;

  void updateCategoriIndex(int newValue) {
    setState(() {
      categorieIndex = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildCategories(
            categorieIndex: categorieIndex,
            updateIndex: updateCategoriIndex,
          ),
          BuildGridProducts(
            categorieIndex: categorieIndex,
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(context.loc.souvenirs),
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            Assets.store.icons.search,
            colorFilter: const ColorFilter.mode(
              grayStoreColor,
              BlendMode.srcIn,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            Assets.store.icons.cart,
            colorFilter: const ColorFilter.mode(
              grayStoreColor,
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
