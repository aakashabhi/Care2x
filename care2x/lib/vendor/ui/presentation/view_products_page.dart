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
    var productProviderWatchContext = context.watch<ProductProvider>();
    var productProviderReadContext = context.read<ProductProvider>();

    List<ProductModel> products = productProviderWatchContext.myProducts;
    print('building product');
    print('jjh ' + products.length.toString());
    print(productProviderWatchContext.gotProducts);
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        backgroundColor: appBarColor,
      ),
      body: productProviderWatchContext.gotProducts
          ? (products.length > 0
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    print(products[index].name);
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
          productProviderReadContext.setVariables('', '', 0.0, false);
          AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.INFO,
            body: ChangeNotifierProvider.value(
              value: productProviderReadContext,
              child: AddDialogBox(),
            ),
            btnOk: MaterialButton(
              onPressed: () {
                productProviderReadContext.addProduct(ProductModel(
                  id: '',
                  name: productProviderReadContext.name,
                  description: productProviderReadContext.description,
                  vendorId: productProviderReadContext.vendorId,
                  imageURL: dummyImageUrl,
                  price: productProviderReadContext.price,
                  inStock: productProviderReadContext.inStock,
                ));
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
