import 'package:care2x/view_products/productitem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsGrid extends StatefulWidget {
  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  bool _isLoading = true;
  var products = [];
  @override
  void initState() {
    () async {
      var prodcoll =
          await FirebaseFirestore.instance.collection('products').get();
      var allprods = prodcoll.docs.map((doc) => doc.data()).toList();

      setState(() {
        for (var product in allprods) {
          products.add(ProductItem(
              DateTime.now().toIso8601String(),
              product['name'],
              product['imageUrl'],
              product['inStock'],
              product['price']));
        }
        _isLoading = false;
        print("Done");
        print(products);
      });
    }();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading==true?Center(child: CircularProgressIndicator(),): GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ProductItem(products[i].id, products[i].title,
          products[i].imageUrl, products[i].inStock, products[i].price),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
