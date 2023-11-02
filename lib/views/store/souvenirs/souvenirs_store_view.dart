import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/gen/assets.gen.dart';
import 'package:museo/models/store/category_product.dart';
import 'package:museo/models/store/product.dart';
import 'package:museo/services/souvenirs_service.dart';
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
  late SouvenirsCategory selectedCategory;
  late List<SouvenirsCategory> categories;
  late List<Product> products;
  bool isDataLoaded = false;

  void updateCategoriIndex(SouvenirsCategory newValue) {
    setState(() {
      selectedCategory = newValue;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    if (!isDataLoaded) {
      List<SouvenirsCategory> dataCategories =
          await SouvenirsService().getProductCategory();
      List<Product> dataProducts = await SouvenirsService().getProduct();
      setState(() {
        selectedCategory = dataCategories[0];
        categories = dataCategories;
        products = dataProducts;
        isDataLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: isDataLoaded
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuildCategories(
                  selectedCategory: selectedCategory,
                  categorys: categories,
                  updateCategory: updateCategoriIndex,
                ),
                BuildGridProducts(
                  selectedCategory: selectedCategory,
                  products: products,
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
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
