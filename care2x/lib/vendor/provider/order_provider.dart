import 'package:care2x/vendor/models/item_model.dart';
import 'package:care2x/vendor/models/order_model.dart';
import 'package:care2x/vendor/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OrderProvider extends ChangeNotifier {
  final String vendorId;
  var orderCollection = FirebaseFirestore.instance.collection("orders");
  var productCollection = FirebaseFirestore.instance.collection("products");

  List<OrderModel> myOrders = [];
  List<ProductModel> myProducts = [];

  OrderProvider({required this.vendorId});

  Future<void> getOrders() async {
    var rawProducts =
        await productCollection.where("vendorId", isEqualTo: vendorId).get();
    var rawProductList = rawProducts.docs.toList();

    var rawOrders = await orderCollection.get();
    var rawOrdersList = rawOrders.docs.toList();

    print('rawproductlist length ' + rawProductList.length.toString());

    for (int i = 0; i < rawProductList.length; i++) {
      var rawProduct = rawProductList[i];
      print('id: ' + rawProduct.id.toString());
      myProducts.add(ProductModel(
          id: rawProduct.id,
          name: rawProduct['name'],
          description: rawProduct['description'],
          vendorId: rawProduct['vendorId'],
          imageURL: rawProduct['imageUrl'],
          price: rawProduct['price'].toDouble(),
          inStock: rawProduct['inStock']));
    }

    for (int j = 0; j < rawOrdersList.length; j++) {
      var order = rawOrdersList[j];
      var rawItems = await order.reference.collection("items").get();
      var rawItemsList = rawItems.docs.toList();
      List<ItemModel> itemsList = <ItemModel>[];

      print(order['email'] + ' : ' + rawItemsList.length.toString());
      for (int i = 0; i < rawItemsList.length; i++) {
        int index = myProducts.indexWhere(
            (element) => element.id == rawItemsList[i]['productId']);
        print(rawItemsList[i]['productId'] + ' ' + index.toString());
        if (index >= 0) {
          itemsList.add(ItemModel(
              productId: rawItemsList[i]['productId'],
              productName: myProducts[index].name,
              quantity: rawItemsList[i]['quantity']));
        }
      }
      print('items length: ' + itemsList.length.toString());
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
