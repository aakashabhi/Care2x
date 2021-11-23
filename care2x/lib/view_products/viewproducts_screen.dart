import 'package:care2x/view_products/productsgrid.dart';
import 'package:flutter/material.dart';

import '../restart_controller.dart';

class ViewProductsScreen extends StatefulWidget {
  ViewProductsScreen({Key? key}) : super(key: key);

  @override
  _ViewProductsScreenState createState() => _ViewProductsScreenState();
}

class _ViewProductsScreenState extends State<ViewProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
          title: Text("Marketplace"),
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          automaticallyImplyLeading: false,
          actions: [
          IconButton(
              onPressed: () {
                HotRestartController.performHotRestart(context);
              },
              icon: Icon(Icons.logout))
        ]),
      body: ProductsGrid(),
    );
  }
}
