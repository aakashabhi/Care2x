import 'dart:ffi';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:care2x/constants/constants.dart';
import 'package:care2x/vendor/models/product_model.dart';
import 'package:care2x/vendor/provider/product_provider.dart';
import 'package:care2x/vendor/ui/widgets/addDialogBox.dart';
import 'package:care2x/vendor/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ViewProductsPage extends StatefulWidget {
  const ViewProductsPage({Key? key}) : super(key: key);

  @override
  State<ViewProductsPage> createState() => _ViewProductsPageState();
}

class _ViewProductsPageState extends State<ViewProductsPage> {
  @override
  void initState() {
    final ProductProvider productProvider = context.read<ProductProvider>();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
      await productProvider.getProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var productProviderContext = context.watch<ProductProvider>();
    List<ProductModel> products = productProviderContext.myProducts;
    print('building product');
    print('jjh ' + products.length.toString());
    print(productProviderContext.gotProducts);
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        backgroundColor: appBarColor,
      ),
      body: productProviderContext.gotProducts
          ? (products.length > 0
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return ProductCard(product: products[index]);
                  },
                  itemCount: products.length,
                )
              : Center(
                  child: Text(
                    'No products to show',
                  ),
                ))
          : SpinKitCircle(
              color: Colors.black,
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          String name = '', description = '';
          double price = 0.0;
          bool inStock = false;
          AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.INFO,
            body: AddDialogBox(),
            btnOk: MaterialButton(
              onPressed: () {
                context.read<ProductProvider>().addProduct(ProductModel(
                    id: '',
                    name: name,
                    description: description,
                    vendorId: context.read<ProductProvider>().vendorId,
                    imageURL: dummyImageUrl,
                    price: price,
                    inStock: inStock));
                Navigator.of(context).pop();
              },
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
            ),
            btnCancel: MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
            ),
          )..show();
        },
        backgroundColor: Colors.black,
        elevation: 0.0,
        label: Text('Add product +'),
      ),
    );
  }
}
