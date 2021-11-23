import 'package:care2x/AddRemedy/add_remedy.dart';
import 'package:care2x/ViewRemedies/view_remedy.dart';
import 'package:care2x/dummy_screens/my_cart.dart';
import 'package:care2x/dummy_screens/order_history.dart';
import 'package:care2x/my_appointments/myappointments_screen.dart';
import 'package:care2x/view_appointments/view_appointments.dart';
import 'package:care2x/view_products/viewproducts_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CustomerScreen extends StatefulWidget {
  CustomerScreen({Key? key}) : super(key: key);
  var screens = [ViewProductsScreen(),MyAppointmentsScreen(), ViewRemedy(),OrderHistory(),MyCart()];
  var _currentIndex = 0;

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        items: <Widget>[
          Icon(Icons.list_alt_outlined, size: 30),
          Icon(Icons.av_timer, size: 30),
          Icon(Icons.medical_services, size: 30),
          Icon(Icons.shopping_bag,size: 30),
          Icon(Icons.shopping_cart_outlined,size: 30)
          
        ],
        onTap: (index) {
          setState(() {
            widget._currentIndex = index;
          });
          print(index);
        },
        height: 50,
      ),
      body: widget.screens[widget._currentIndex],
    );
  }
}
