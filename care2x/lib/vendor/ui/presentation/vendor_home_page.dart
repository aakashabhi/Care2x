import 'package:care2x/constants/constants.dart';
import 'package:care2x/vendor/provider/order_provider.dart';
import 'package:care2x/vendor/provider/product_provider.dart';
import 'package:care2x/vendor/ui/presentation/view_orders_page.dart';
import 'package:care2x/vendor/ui/presentation/view_products_page.dart';
import 'package:care2x/vendor/ui/widgets/pending_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../restart_controller.dart';

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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home'),
        backgroundColor: appBarColor,
        actions: [
          IconButton(
              onPressed: () {
                HotRestartController.performHotRestart(context);
              },
              icon: Icon(Icons.logout))
        ],
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
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/orders.png',
                      width: MediaQuery.of(context).size.width * .15,
                      height: MediaQuery.of(context).size.width * .15,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'View Orders',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 25,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              color: buttonColor,
            ),
            SizedBox(
              height: 18,
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
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/products.png',
                      width: MediaQuery.of(context).size.width * .15,
                      height: MediaQuery.of(context).size.width * .15,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'View Products',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 25,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              color: buttonColor,
            ),
            SizedBox(
              height: 26,
            ),
            Text(
              'Pending Urgent Orders',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            SizedBox(
              height: 10,
            ),
            ChangeNotifierProvider(
                create: (context)=>OrderProvider(vendorId: widget.vendorId),
                child: PendingUrgentOrder()),
          ],
        ),
      ),
    );
  }
}
