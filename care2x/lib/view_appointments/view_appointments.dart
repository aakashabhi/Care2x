import 'package:care2x/AddRemedy/add_remedy.dart';
import 'package:care2x/screens/doctor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../restart_controller.dart';
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
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text("My Appointments"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                HotRestartController.performHotRestart(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: _isLoading == true
          ? Center(child: CircularProgressIndicator())
          : appointments.length > 0
              ? ListView.builder(
                  itemBuilder: (_, index) {
                    return AppointmentCard(
                        patientemail: appointments[index]['patientEmail'],
                        time: appointments[index]['time']);
                  },
                  itemCount: appointments.length,
                )
              : Center(
                  child: Text(
                    "You have no appointments for today",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
    );
  }
}
