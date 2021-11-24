import 'package:care2x/Cart/models/cart_item_model.dart';
import 'package:care2x/Cart/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:provider/provider.dart';

class CartCard extends StatefulWidget {
  final CartItemModel item;
  

  const CartCard({Key? key, required this.item}) : super(key: key);

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  late int quantity;
  @override
  void initState() {
    quantity = widget.item.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cartProviderReadContext = context.read<CartProvider>();
    return Card(
      color: Colors.grey[500],
      child: ListTile(
          title: Text(
            widget.item.productName,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          trailing: ElegantNumberButton(
            key: ValueKey(widget.item.productId),
            color: Colors.white,
            buttonSizeWidth: 26,
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            initialValue: quantity,
            minValue: 0,
            maxValue: 6,
            step: 1,
            onChanged: (val) {
              setState(() {
                int q = val.toInt();
                if (q == 0) {
                  cartProviderReadContext
                      .decrementItemQuantity(widget.item.productId);
                }
                if (q > quantity) {
                  cartProviderReadContext
                      .incrementItemQuantity(widget.item.productId);
                } else {
                  cartProviderReadContext
                      .decrementItemQuantity(widget.item.productId);
                }
                quantity = val.toInt();
              });
            },
            decimalPlaces: 0,
          )),
    );
  }
}
