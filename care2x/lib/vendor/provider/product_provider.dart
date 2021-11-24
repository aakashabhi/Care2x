import 'package:care2x/vendor/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider extends ChangeNotifier {
  final String vendorId;

  bool gotProducts = false;

  ProductProvider({required this.vendorId});

  List<ProductModel> myProducts = <ProductModel>[];

  var productCollection = FirebaseFirestore.instance.collection('products');

  Future<void> getProducts() async {
    var rawProducts =
        await productCollection.where('vendorId', isEqualTo: vendorId).get();
    var rawProductList = rawProducts.docs.toList();
    print(rawProductList.length);
    rawProductList.forEach((product) {
      print(product['name']);
      myProducts.add(ProductModel(
        id: product.id,
        name: product['name'],
        description: product['description'],
        vendorId: product['vendorId'],
        imageURL: product['imageUrl'],
        price: product['price'].toDouble(),
        inStock: product['inStock'],
      ));
    });
    print('lenth ' + myProducts.length.toString());
    gotProducts = true;
    notifyListeners();
  }

  void addProduct(ProductModel product) async {
    var rawProduct = {
      'description': product.description,
      'name': product.name,
      'imageUrl': product.imageURL,
      'inStock': product.inStock,
      'price': product.price,
      'vendorId': product.vendorId,
    };
    ProductModel addProductToList;
    await productCollection.add(rawProduct).then((value) {
      addProductToList = ProductModel(
          id: value.id,
          name: product.name,
          description: product.description,
          vendorId: vendorId,
          imageURL: product.imageURL,
          price: product.price,
          inStock: product.inStock);
      myProducts.add(addProductToList);
    });
    notifyListeners();
  }

  void deleteProduct(String productId) async {
    int index = myProducts.indexWhere((p) => p.id == productId);
    if (index >= 0) {
      myProducts.removeAt(index);
      await productCollection.doc(productId).delete();
    }
    notifyListeners();
  }

  void editProduct(String productId, ProductModel product) async {
    int index = myProducts.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      myProducts.removeAt(index);
      myProducts.insert(index, product);
      await productCollection.doc(productId).update({
        'description': product.description,
        'name': product.name,
        'imageUrl': product.imageURL,
        'inStock': product.inStock,
        'price': product.price,
        'vendorId': product.vendorId,
      });
    }
    notifyListeners();
  }
}
