import 'package:care2x/AddRemedy/add_remedy.dart';
import 'package:care2x/view_appointments/view_appointments.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class DoctorScreen extends StatefulWidget {
  DoctorScreen({Key? key}) : super(key: key);
  var screens = [ViewAppointments(), AddRemedy()];
  var _currentIndex = 0;

  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        items: <Widget>[
          Icon(Icons.remove_red_eye, size: 30),
          Icon(Icons.add, size: 30),
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
