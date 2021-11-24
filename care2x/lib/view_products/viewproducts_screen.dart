import 'package:care2x/Cart/provider/cart_provider.dart';
import 'package:care2x/Cart/ui/presentation/viewCart.dart';
import 'package:care2x/view_products/productsgrid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../restart_controller.dart';

class ViewProductsScreen extends StatefulWidget {
  ViewProductsScreen({Key? key}) : super(key: key);

  @override
  _ViewProductsScreenState createState() => _ViewProductsScreenState();
}

class _ViewProductsScreenState extends State<ViewProductsScreen> {
  @override
  Widget build(BuildContext context) {
    var cartProviderReadContext = context.read<CartProvider>();
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
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            print('item length: ' +cartProviderReadContext.cartModel.items.length.toString());
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider.value(
                      value: cartProviderReadContext,
                      child: ViewCart(),
                    )));
          },
          backgroundColor: Colors.black,
          label: Row(
            children: [
              Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Cart',
                style: TextStyle(fontSize: 18),
              ),
            ],
          )),
    );
  }
}
