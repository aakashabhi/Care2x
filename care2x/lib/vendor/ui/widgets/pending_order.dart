import 'package:care2x/vendor/provider/order_provider.dart';
import 'package:care2x/vendor/ui/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class PendingUrgentOrder extends StatefulWidget {
  const PendingUrgentOrder({Key? key}) : super(key: key);

  @override
  State<PendingUrgentOrder> createState() => _PendingUrgentOrderState();
}

class _PendingUrgentOrderState extends State<PendingUrgentOrder> {
  void initState() {
    final OrderProvider orderProvider = context.read<OrderProvider>();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
      await orderProvider.getOrders();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pendingWatchContext = context.watch<OrderProvider>();
    var pendingReadContext = context.read<OrderProvider>();
    return pendingWatchContext.gotOrders == true
        ? (pendingWatchContext.urgentPendingOrders.length > 0
            ? Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return OrderCard(
                        order: pendingReadContext.urgentPendingOrders[index],
                        index: index);
                  },
                  itemCount: pendingReadContext.urgentPendingOrders.length,
                ),
              )
            : Text(
                'No Urgent Pending Orders',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ))
        : SpinKitCircle(
            color: Colors.black,
          );
  }
}
