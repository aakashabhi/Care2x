import 'package:care2x/vendor/models/item_model.dart';
import 'package:care2x/vendor/models/order_model.dart';
import 'package:care2x/vendor/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OrderProvider extends ChangeNotifier {
  final String vendorId;
  var orderCollection = FirebaseFirestore.instance.collection("orders");
  var productCollection = FirebaseFirestore.instance.collection("product");

  List<OrderModel> myOrders = [];
  List<ProductModel> myProducts = [];

  OrderProvider({required this.vendorId});

  Future<void> getOrders() async {
    var rawProducts =
        await productCollection.where("vendorId", isEqualTo: vendorId).get();
    var rawProductList = rawProducts.docs.toList();

    var rawOrders = await orderCollection.get();
    var rawOrdersList = rawOrders.docs.toList();

    print(rawOrdersList.length);

    rawProductList.forEach((element) {
      myProducts.add(ProductModel(
          id: element.id,
          name: element['name'],
          description: element['description'],
          vendorId: element['vendorId'],
          imageURL: element['imageURL'],
          price: element['price'].toDouble(),
          inStock: element['inStock']));
    });

    for (int j = 0; j < rawOrdersList.length; j++) {
      var order = rawOrdersList[j];
      var rawItems = await order.reference.collection("items").get();
      var rawItemsList = rawItems.docs.toList();
      List<ItemModel> itemsList = <ItemModel>[];
      
      for (int i = 0; i < rawItemsList.length; i++) {
        int index = myProducts.indexWhere(
            (element) => element.id == rawItemsList[i]['productId']);
        if (index >= 0) {
          itemsList.add(ItemModel(
              productId: rawItemsList[i]['productId'],
              quantity: rawItemsList[i]['quantity']));
        }
      }

      myOrders.add(OrderModel(
          email: order['email'],
          isComplete: order['isComplete'],
          isUrgent: order['isUrgent'],
          orderDate: order['orderDate'].toDate(),
          totalCost: order['totalCost'].toDouble(),
          items: itemsList));
    }
  
    print('got my orders');
    print(myOrders.length);
    notifyListeners();
    return;
  }
}
