import 'package:care2x/vendor/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final int index;
  const OrderCard({Key? key, required this.order, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          'Order ' + index.toString(),
          style: TextStyle(fontSize: 16),
        ),
        trailing: MaterialButton(
          onPressed: () {},
          child: Text('View details'),
        ),
      ),
    );
  }
}
