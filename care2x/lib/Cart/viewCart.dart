import 'package:care2x/Cart/Cart.dart';
import 'package:flutter/material.dart';

class ViewCart extends StatefulWidget {
  const ViewCart({Key? key}) : super(key: key);

  @override
  _ViewCartState createState() => _ViewCartState();
}

class _ViewCartState extends State<ViewCart> {
  List<Product> orders = [
    Product(id: 1, name: 'Paracetamol', price: 10, qnt: 1),
    Product(id: 2, name: 'Allegra', price: 20, qnt: 2),
    Product(id: 3, name: 'Fentanyl', price: 40, qnt: 3),
    Product(id: 4, name: 'Gilenya', price: 80, qnt: 4),
    Product(id: 5, name: 'Sublocade', price: 100, qnt: 5),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Your Cart'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  onTap: () {},
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        orders[index].id.toString(),
                      ),
                      Text(
                        orders[index].name.toString(),
                      ),
                      Text(
                        orders[index].price.toString(),
                      ),
                      Text(
                        orders[index].qnt.toString(),
                      ),
                      IconButton(
                        icon: const Icon(Icons.check_circle),
                        color: Colors.green,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
