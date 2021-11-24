import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:care2x/constants/constants.dart';
import 'package:care2x/vendor/models/product_model.dart';
import 'package:care2x/vendor/provider/product_provider.dart';
import 'package:care2x/vendor/ui/widgets/editDialogBox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    var productProviderReadContext = context.read<ProductProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Card(
        color: Colors.grey[400],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: ExpansionTile(
            title: Text(
              widget.product.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            children: [
              Text(
                'Description: ' + widget.product.description,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Price: ' + widget.product.price.toString(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    color: Colors.black,
                    onPressed: () {
                      String name = widget.product.name,
                          description = widget.product.description;
                      double price = widget.product.price;
                      bool inStock = widget.product.inStock;
                      productProviderReadContext.setVariables(
                          name, description, price, inStock);
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.SCALE,
                        dialogType: DialogType.INFO,
                        btnOk: MaterialButton(
                          onPressed: () {
                            productProviderReadContext.editProduct(
                                widget.product.id,
                                ProductModel(
                                    id: widget.product.id,
                                    name: productProviderReadContext.name,
                                    description:
                                        productProviderReadContext.description,
                                    vendorId: widget.product.vendorId,
                                    imageURL: dummyImageUrl,
                                    price: productProviderReadContext.price,
                                    inStock:
                                        productProviderReadContext.inStock));
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Edit',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.black,
                        ),
                        body: ChangeNotifierProvider.value(
                          value: productProviderReadContext,
                          child: EditDialogBox(
                            description: widget.product.description,
                            inStock: widget.product.inStock,
                            name: widget.product.name,
                            price: widget.product.price,
                          ),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.edit,
                          size: 25,
                          color: Colors.green[100],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Edit',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    color: Colors.black,
                    onPressed: () {
                      context
                          .read<ProductProvider>()
                          .deleteProduct(widget.product.id);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.delete,
                          size: 25,
                          color: Colors.red[200],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Delete',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
