import 'package:flutter/material.dart';

class OrderDetail extends StatefulWidget {
  final dateStamp;
  OrderDetail(this.dateStamp);
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  String? year, month, day, hour, min, second;
  @override
  void initState() {
    DateTime date = widget.dateStamp.toDate();
    year = date.year.toString();
    month = date.month.toString();
    day = date.day.toString();
    hour = date.hour.toString();
    min = date.minute.toString();
    second = date.second.toString();
    if (hour == '0')
      hour = '00';
    else if (hour!.length == 1) {
      String nhour = '0' + hour!;
      hour = nhour;
    }
    if (min == '0')
      year = '00';
    else if (min!.length == 1) {
      String nmin = '0' + min!;
      min = nmin;
    }
    if (second == '0')
      second = '00';
    else if (second!.length == 1) {
      String nsecond = '0' + second!;
      second = nsecond;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          year! + "/" + month! + "/" + day!,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(" @ "),
        Text(
          month! + ":" + min! + ":" + second!,
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
