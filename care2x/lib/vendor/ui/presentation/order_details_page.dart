import 'package:care2x/constants/constants.dart';
import 'package:care2x/vendor/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderDetailsPage extends StatefulWidget {
  final OrderModel order;
  final int orderNo;
  const OrderDetailsPage({Key? key, required this.order, required this.orderNo})
      : super(key: key);

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text('Order ' + widget.orderNo.toString()),
        backgroundColor: appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 22, horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'User Email: ' + widget.order.email,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Order Date: ' +
                                  widget.order.orderDate.day.toString() +
                                  '/' +
                                  widget.order.orderDate.month.toString() +
                                  '/' +
                                  widget.order.orderDate.year.toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.house,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Address: ' + widget.order.address,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.money,
                              color: Colors.blue[200],
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Total Cost: ' +
                                  widget.order.totalCost.toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.blue[100]),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        widget.order.isUrgent
                            ? Row(
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    'Urgent Order',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.red),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Icon(
                                    Icons.done,
                                    color: Colors.blue[100],
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    'Not Urgent Order',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.blue[100]),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 12,
                        ),
                        widget.order.isComplete
                            ? Row(
                                children: [
                                  Icon(
                                    Icons.done,
                                    color: Colors.green[200],
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    'Order Complete',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.green[200]),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Icon(
                                    Icons.cancel,
                                    color: Colors.blue[100],
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    'Order Incomplete',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.blue[100]),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                'Order Items',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                height: 5,
                color: Colors.black,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Product',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Quantity',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ...[
                for (int i = 0; i < widget.order.items.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[500],
                          borderRadius: BorderRadius.circular(7)),
                      child: ListTile(
                        trailing: Text(
                          widget.order.items[i].quantity.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        title: Text(
                          widget.order.items[i].productName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
