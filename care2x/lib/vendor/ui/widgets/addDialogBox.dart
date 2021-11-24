import 'package:care2x/vendor/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDialogBox extends StatefulWidget {
  const AddDialogBox({
    Key? key,
  }) : super(key: key);

  @override
  _AddDialogBoxState createState() => _AddDialogBoxState();
}

class _AddDialogBoxState extends State<AddDialogBox> {
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
              productProviderReadContext.price = double.parse(val);
            },
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
