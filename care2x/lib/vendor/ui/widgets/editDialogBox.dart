import 'package:flutter/material.dart';

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
  late String name, description;
  late double price;
  late bool inStock;
  
  @override
  void initState() {
    name = widget.name;
    description = widget.description;
    price = widget.price;
    inStock = widget.inStock;
    super.initState();
  }

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
            initialValue: name,
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
            initialValue: description,
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
            initialValue: price.toString(),
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
            selected: inStock,
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
