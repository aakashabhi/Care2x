import 'package:care2x/constants/constants.dart';
import 'package:flutter/material.dart';

class ViewCart extends StatefulWidget {
  const ViewCart({Key? key}) : super(key: key);

  @override
  _ViewCartState createState() => _ViewCartState();
}

class _ViewCartState extends State<ViewCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: appBarColor,
      ),
      body: Container(),
    );
  }
}
