import 'package:care2x/Cart/models/cart_model.dart';
import 'package:care2x/login/models/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  final Customer customer;
  var orderCollection = FirebaseFirestore.instance.collection('orders');

  CartProvider({required this.customer});

  void placeOrder(CartModel cart) {
    cart.items.forEach((item) {});
  }
}
