import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/gen/assets.gen.dart';
import 'package:museo/helpers/color_from_api.dart';
import 'package:museo/helpers/price.dart';
import 'package:museo/models/store/product.dart';
import 'package:museo/views/store/souvenirs/components/build_cart_counter.dart';
import 'package:museo/views/store/souvenirs/components/build_color_and_size.dart';

class SouvenirsDetailsView extends StatelessWidget {
  final Product product;

  const SouvenirsDetailsView({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorFromApi(color: product.color),
      appBar: buildAppBar(),
      body: Stack(
        children: [
          ProductDescription(size: size, product: product),
          ProductWithImage(product: product),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: colorFromApi(color: product.color),
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(Assets.store.icons.search),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(Assets.store.icons.cart),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    super.key,
    required this.size,
    required this.product,
  });

  final Size size;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: size.height * 0.52,
        padding: EdgeInsets.only(
          top: size.height * 0.12,
          left: 20,
          right: 20,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BuildColorAndSize(product: product),
              const SizedBox(height: 10),
              Description(product: product),
              const SizedBox(height: 10),
              const CounterWithFavoriteButton(),
              const SizedBox(height: 10),
              AddToCart(product: product)
            ],
          ),
        ),
      ),
    );
  }
}

class AddToCart extends StatelessWidget {
  const AddToCart({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: colorFromApi(color: product.color)),
            ),
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                Assets.store.icons.addToCart,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorFromApi(color: product.color),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      18,
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'BUY NOW',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CounterWithFavoriteButton extends StatelessWidget {
  const CounterWithFavoriteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const BuildCartCounter(),
        Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            color: Colors.red.shade500,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.favorite,
            color: Colors.white,
            size: 24,
          ),
        )
      ],
    );
  }
}

class Description extends StatelessWidget {
  const Description({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        product.description,
        textAlign: TextAlign.justify,
        style: const TextStyle(),
      ),
    );
  }
}

class ProductWithImage extends StatelessWidget {
  const ProductWithImage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hand Bag',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            product.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: '${context.loc.price}\n'),
                    TextSpan(
                      text: generatePrice(price: product.price),
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Hero(
                  tag: '${product.id}',
                  child: Image(
                    image: NetworkImage(product.image),
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
