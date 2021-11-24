import 'package:care2x/constants/constants.dart';
import 'package:care2x/vendor/models/order_model.dart';
import 'package:care2x/vendor/provider/order_provider.dart';
import 'package:care2x/vendor/ui/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ViewOrdersPage extends StatefulWidget {
  const ViewOrdersPage({Key? key}) : super(key: key);

  @override
  State<ViewOrdersPage> createState() => _ViewOrdersPageState();
}

class _ViewOrdersPageState extends State<ViewOrdersPage> {
  @override
  void initState() {
    final OrderProvider orderProvider = context.read<OrderProvider>();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
      await orderProvider.getOrders();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<OrderModel> orders = context.watch<OrderProvider>().myOrders;
    print('bulidng orders');
    print('hhy ' + orders.length.toString());
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text('Orders'),
          backgroundColor: appBarColor,
        ),
        body: context.watch<OrderProvider>().gotOrders == true
            ? (orders.length > 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return OrderCard(order: orders[index], index: index);
                      },
                      itemCount: orders.length,
                    ),
                  )
                : SpinKitCircle(
                    color: Colors.black,
                  ))
            : Center(
                child: Text(
                  'No Orders',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ));
  }
}
