import 'package:care2x/Order_history/order_history.dart';
import 'package:care2x/vendor/models/order_model.dart';
import 'package:care2x/vendor/provider/order_provider.dart';
import 'package:care2x/vendor/ui/presentation/order_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final int index;
  const OrderCard({Key? key, required this.order, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Card(
        color: Colors.grey[500],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            title: Text(
              'Order ' + (index + 1).toString(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: MaterialButton(
              elevation: 0.0,
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider.value(
                          value: context.read<OrderProvider>(),
                          child: OrderDetailsPage(
                            order: order,
                            orderNo: index + 1,
                          ),
                        )));
              },
              child: Text(
                'View details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
