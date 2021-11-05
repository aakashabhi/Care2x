import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../session_repo.dart';
import 'appointmentcard.dart';

class ViewAppointments extends StatefulWidget {
  const ViewAppointments({Key? key}) : super(key: key);

  @override
  State<ViewAppointments> createState() => _ViewAppointmentsState();
}

class _ViewAppointmentsState extends State<ViewAppointments> {
  List<Map<dynamic, dynamic>> appointments = [];
  late bool _isLoading;

  @override
  void initState() {
    // TODO: implement initState
    _isLoading = true;
    () async {
      await RepositoryProvider.of<SessionRepository>(context).getappointments();
      setState(() {
        appointments = RepositoryProvider.of<SessionRepository>(context)
            .doctorappointments;
        _isLoading = false;
      });
    }();
    print(appointments.length);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final makeListTile = ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: Text(
        "Introduction to Driving",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

      subtitle: Row(
        children: <Widget>[
          Icon(Icons.linear_scale, color: Colors.yellowAccent),
          Text(" Intermediate", style: TextStyle(color: Colors.white))
        ],
      ),
    );
    final makeCard = Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile,
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text("My Appointments"),
        automaticallyImplyLeading: false,
      ),
      body: _isLoading == true
          ? CircularProgressIndicator()
          : appointments.length > 0
              ? ListView.builder(
                  itemBuilder: (_, index) {
                    return AppointmentCard(
                        patientemail: appointments[index]['patientEmail'],
                        time: appointments[index]['time']);
                  },
                  itemCount: appointments.length,
                )
              : Text("You have no appointments for today"),
    );
  }
}
