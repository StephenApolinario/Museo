import 'package:flutter/material.dart';
import 'package:museo/gen/assets.gen.dart';

class Product {
  final String image, title, description;
  final int price, size, id;
  final Color color;

  Product({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.size,
    required this.id,
    required this.color,
  });
}

class SouvenirsCategory {
  final String name;
  final List<Product> products;

  SouvenirsCategory({
    required this.name,
    required this.products,
  });
}

List<SouvenirsCategory> fakeSouvenirsList = [
  SouvenirsCategory(
    name: 'Bonés',
    products: fakeProductCaps,
  ),
  SouvenirsCategory(
    name: 'Bolsas',
    products: fakeProductBags,
  ),
  SouvenirsCategory(
    name: 'Camisas',
    products: fakeProductBags,
  ),
  SouvenirsCategory(
    name: 'Camisetas',
    products: fakeProductBags,
  ),
  SouvenirsCategory(
    name: 'Moletons',
    products: fakeProductBags,
  ),
];

List<Product> fakeProductBags = [
  Product(
    id: 1,
    title: 'Office Code',
    price: 234,
    size: 12,
    description: dummyText,
    image: Assets.store.images.bags.bag1.path,
    color: const Color(0xFF3D82AE),
  ),
  Product(
    id: 2,
    title: 'Belt Bag',
    price: 234,
    size: 8,
    description: dummyText,
    image: Assets.store.images.bags.bag2.path,
    color: const Color(0xFFD3A984),
  ),
  Product(
    id: 3,
    title: 'Hang Top',
    price: 234,
    size: 10,
    description: dummyText,
    image: Assets.store.images.bags.bag3.path,
    color: const Color(0xFF989493),
  ),
  Product(
    id: 4,
    title: 'Old Fashion',
    price: 234,
    size: 11,
    description: dummyText,
    image: Assets.store.images.bags.bag4.path,
    color: const Color(0xFFE6B398),
  ),
  Product(
    id: 5,
    title: 'Office Code',
    price: 234,
    size: 12,
    description: dummyText,
    image: Assets.store.images.bags.bag5.path,
    color: const Color(0xFFFB7883),
  ),
  Product(
    id: 6,
    title: 'Office Code',
    price: 234,
    size: 12,
    description: dummyText,
    image: Assets.store.images.bags.bag6.path,
    color: const Color(0xFFAEAEAE),
  ),
];

List<Product> fakeProductCaps = [
  Product(
    id: 1,
    title: 'Boné Tuba',
    price: 234,
    size: 12,
    description: dummyText,
    image: Assets.store.images.caps.cap1.path,
    color: const Color(0xFF3D82AE),
  ),
  Product(
    id: 2,
    title: 'Belt Bag',
    price: 234,
    size: 8,
    description: dummyText,
    image: Assets.store.images.caps.cap2.path,
    color: const Color(0xFFD3A984),
  ),
  Product(
    id: 3,
    title: 'Hang Top',
    price: 234,
    size: 10,
    description: dummyText,
    image: Assets.store.images.caps.cap3.path,
    color: const Color(0xFF989493),
  ),
  Product(
    id: 4,
    title: 'Old Fashion',
    price: 234,
    size: 11,
    description: dummyText,
    image: Assets.store.images.caps.cap4.path,
    color: const Color(0xFFE6B398),
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
