import 'package:care2x/vendor/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditDialogBox extends StatefulWidget {
  final String name, description;
  final double price;
  final bool inStock;
  const EditDialogBox(
      {Key? key,
      required this.name,
      required this.description,
      required this.price,
      required this.inStock})
      : super(key: key);

  @override
  _EditDialogBoxState createState() => _EditDialogBoxState();
}

class _EditDialogBoxState extends State<EditDialogBox> {
  @override
  Widget build(BuildContext context) {
    final productProviderReadContext = context.read<ProductProvider>();
    final productProviderWatchContext = context.watch<ProductProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Text(
            'Add Product',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (val) {
              productProviderReadContext.name = val;
            },
            initialValue: widget.name,
            decoration: InputDecoration(
                labelText: 'Name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                hintText: 'Enter Name'),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (val) {
              productProviderReadContext.description = val;
            },
            initialValue: widget.description,
            decoration: InputDecoration(
                labelText: 'Description',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                hintText: 'Enter Name'),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (val) {
              if (val != "") {
                productProviderReadContext.price = double.parse(val);
              } else {
                productProviderReadContext.price = 0.0;
              }
            },
            initialValue: widget.price.toString(),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: 'Price',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                hintText: 'Enter Price'),
          ),
          SizedBox(
            height: 10,
          ),
          CheckboxListTile(
            title: Text('In Stock'),
            value: productProviderWatchContext.inStock,
            onChanged: (val) {
              productProviderReadContext
                  .toggleInStock(!productProviderReadContext.inStock);
            },
            checkColor: Colors.green,
            activeColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
