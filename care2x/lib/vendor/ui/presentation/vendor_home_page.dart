import 'package:care2x/constants/constants.dart';
import 'package:care2x/vendor/provider/order_provider.dart';
import 'package:care2x/vendor/provider/product_provider.dart';
import 'package:care2x/vendor/ui/presentation/view_orders_page.dart';
import 'package:care2x/vendor/ui/presentation/view_products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class VendorHomePage extends StatefulWidget {
  final String vendorId;
  const VendorHomePage({Key? key, required this.vendorId}) : super(key: key);

  @override
  State<VendorHomePage> createState() => _VendorHomePageState();
}

class _VendorHomePageState extends State<VendorHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MaterialButton(
              onPressed: () {
                        
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                        create: (context) =>
                            OrderProvider(vendorId: widget.vendorId),
                        child: ViewOrdersPage())));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Text(
                  'View Orders',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              color: buttonColor,
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider<ProductProvider>(
                        create: (context) =>
                            ProductProvider(vendorId: widget.vendorId),
                        child: ViewProductsPage())));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Text(
                  'View Products',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              color: buttonColor,
            ),
          ],
        ),
      ),
    );
  }
}
