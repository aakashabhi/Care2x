import 'dart:core';

import 'package:care2x/vendor/models/item_model.dart';

class OrderModel {
  final String email;
  final bool isComplete;
  final bool isUrgent;
  final DateTime orderDate;
  final double totalCost;
  final List<ItemModel> items;

  OrderModel(
      {required this.email,
      required this.isComplete,
      required this.isUrgent,
      required this.orderDate,
      required this.totalCost,
      required this.items});
}
