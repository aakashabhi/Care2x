import 'package:care2x/Cart/models/cart_item_model.dart';
import 'package:care2x/Cart/models/cart_model.dart';
import 'package:care2x/login/models/customer.dart';
import 'package:care2x/vendor/models/item_model.dart';
import 'package:care2x/vendor/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  final Customer customer;
  var orderCollection = FirebaseFirestore.instance.collection('orders');

  CartProvider({required this.customer});

  CartModel cartModel = CartModel();
  bool isUrgent = false;
  double totalCost = 0.0;

  bool placingOrder = false;

  void toggleIsUrgent(bool currentVal) {
    isUrgent = currentVal;
    notifyListeners();
  }

  void placeOrder() async {
    placingOrder = true;
    notifyListeners();
    var rawOrder = {
      'email': customer.email,
      'isComplete': false,
      'isUrgent': isUrgent,
      'orderDate': Timestamp.fromDate(DateTime.now()),
      'totalCost': totalCost,
    };
    String id = '';
    await orderCollection.add(rawOrder).then((value) {
      id = value.id;
    });

    var currentOrder = orderCollection.doc(id);
    for (int i = 0; i < cartModel.items.length; i++) {
      print('product id: ' + cartModel.items[i].productId);
      await currentOrder.collection('items').add({
        'productId': cartModel.items[i].productId,
        'quantity': cartModel.items[i].quantity
      });
    }
    cartModel.items.clear();
    placingOrder = false;
    notifyListeners();
  }

  void addItemToCart(String productId, int cost, String productName) {
    print('adding');
    int index =
        cartModel.items.indexWhere((element) => element.productId == productId);
    int quantity = 1;
    if (index >= 0) {
      cartModel.items[index].quantity++;
      quantity = cartModel.items[index].quantity;
    } else {
      CartItemModel cartItemModel =
          CartItemModel(productId: productId, productName: productName);
      cartItemModel.quantity = 1;
      cartItemModel.cost = cost;
      cartModel.items.add(cartItemModel);
    }
    totalCost += (cost * quantity).toDouble();

    print(totalCost.toString());

    notifyListeners();
  }

  void decrementItemQuantity(String productId) {
    int index =
        cartModel.items.indexWhere((element) => element.productId == productId);

    if (index >= 0) {
      cartModel.items[index].quantity--;
      totalCost -= cartModel.items[index].cost;
      if (cartModel.items[index].quantity == 0) {
        cartModel.items.removeAt(index);
      }
    }
    notifyListeners();
  }

  void incrementItemQuantity(String productId) {
    int index =
        cartModel.items.indexWhere((element) => element.productId == productId);

    if (index >= 0) {
      cartModel.items[index].quantity++;
      totalCost += cartModel.items[index].cost;
    }
    notifyListeners();
  }

  void emptyCart() {
    cartModel.items.clear();
    totalCost = 0.0;
    notifyListeners();
  }
}
