import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final String patientemail;
  final Timestamp time;
  AppointmentCard({required this.patientemail, required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          title: Text(patientemail,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Container(
            child: Text(time.toDate().toString().substring(11, 16),
                style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
