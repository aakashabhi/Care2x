import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:care2x/Cart/provider/cart_provider.dart';
import 'package:care2x/Cart/ui/widgets/cart_card.dart';
import 'package:care2x/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ViewCart extends StatefulWidget {
  const ViewCart({Key? key}) : super(key: key);

  @override
  _ViewCartState createState() => _ViewCartState();
}

class _ViewCartState extends State<ViewCart> {
  @override
  Widget build(BuildContext context) {
    var cartProviderReadContext = context.read<CartProvider>();
    var cartProviderWatchContext = context.watch<CartProvider>();

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Cart'),
          backgroundColor: appBarColor,
        ),
        body: cartProviderWatchContext.placingOrder == false
            ? (cartProviderWatchContext.cartModel.items.length > 0
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Product',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Quantity',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          ...[
                            for (int i = 0;
                                i <
                                    cartProviderWatchContext
                                        .cartModel.items.length;
                                i++)
                              CartCard(
                                  key: ValueKey(cartProviderWatchContext
                                      .cartModel.items[i].productId),
                                  item: cartProviderWatchContext
                                      .cartModel.items[i])
                          ],
                          SizedBox(
                            height: 16,
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Cost',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  cartProviderWatchContext.totalCost.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          CheckboxListTile(
                            value: cartProviderWatchContext.isUrgent,
                            title: Text(
                              'Urgent Order?',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onChanged: (val) {
                              setState(() {
                                cartProviderReadContext.toggleIsUrgent(
                                    !cartProviderReadContext.isUrgent);
                              });
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MaterialButton(
                                color: buttonColor,
                                onPressed: () {
                                  AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.QUESTION,
                                      btnOk: MaterialButton(
                                        color: Colors.grey[500],
                                        onPressed: () {
                                          cartProviderReadContext.placeOrder();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Order',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      btnCancel: MaterialButton(
                                        color: Colors.grey[500],
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ))
                                    ..show();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 10),
                                  child: Text(
                                    'Place Order',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                              MaterialButton(
                                color: buttonColor,
                                onPressed: () {
                                  cartProviderReadContext.emptyCart();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 10),
                                  child: Text(
                                    'Empty Cart',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/empty_cart.png',
                          width: 80,
                          height: 80,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Cart is Empty !',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ))
            : SpinKitCircle(
                color: Colors.black,
              ));
  }
}
