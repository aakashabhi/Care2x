import 'package:care2x/vendor/models/item_model.dart';

class CartModel {
  final List<ItemModel> items;
  final double total;

  CartModel({required this.items, required this.total});
}
