class CartItemModel {
  final String productId;
  final String productName;
  int quantity = 0;
  late int cost;

  CartItemModel({required this.productId, required this.productName});
}
