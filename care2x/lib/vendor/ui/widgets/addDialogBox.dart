import 'package:flutter/material.dart';

class AddDialogBox extends StatefulWidget {
  const AddDialogBox({
    Key? key,
  }) : super(key: key);

  @override
  _AddDialogBoxState createState() => _AddDialogBoxState();
}

class _AddDialogBoxState extends State<AddDialogBox> {
  String name = '', description = '';
  double price = 0.0;
  bool inStock = false;

  @override
  Widget build(BuildContext context) {
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
              name = val;
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
              description = val;
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
              price = double.parse(val);
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
            value: inStock,
            onChanged: (val) {
              setState(() {
                inStock = val!;
              });
            },
            checkColor: Colors.green,
            activeColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
