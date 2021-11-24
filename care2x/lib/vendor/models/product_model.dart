import 'dart:core';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final String vendorId;
  final String imageURL;
  final double price;
  final bool inStock;

  ProductModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.vendorId,
      required this.imageURL,
      required this.price,
      required this.inStock});
}
