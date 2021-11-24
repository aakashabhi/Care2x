import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../session_repo.dart';
import 'package:intl/intl.dart';

class MyAppointmentsScreen extends StatefulWidget {
  MyAppointmentsScreen({Key? key}) : super(key: key);

  @override
  _MyAppointmentsScreenState createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {
  late List<List<dynamic>> doctormap = [];
  bool _isLoading = true;
  bool _isbooked() {
    return true;
  }

  @override
  void initState() {
    _isLoading = true;
    () async {
      var doccoll =
          await FirebaseFirestore.instance.collection('doctors').get();
      var doctorlist = doccoll.docs.map((doc) => doc.data()).toList();
      for (var docrecord in doctorlist) {
        var docrec = await FirebaseFirestore.instance
            .collection('userData')
            .where("email", isEqualTo: docrecord['email'])
            .get();
        var record = docrec.docs.map((doc) => doc.data()).toList()[0];
        var apptable = await FirebaseFirestore.instance
            .collection('appointments')
            .where(
              "time",
              isGreaterThan: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day),
            )
            .get();
        var apprecords = apptable.docs.map((doc) {
          if (doc.data()['patientEmail'] ==
              RepositoryProvider.of<SessionRepository>(context)
                  .loggedinCustomer
                  .email) {
            return doc.data()['doctorEmail'];
          }
        }).toList();
        print(apprecords);
        setState(() {
          String _isdone = "true";
          if (apprecords
                  .indexWhere((element) => element == docrecord['email']) >=
              0) {
            _isdone = "true";
          } else {
            _isdone = "false";
          }
          doctormap.add([
            docrecord['email'],
            record['firstName'] + " " + record['lastName'],
            docrecord['specialisation'],
            docrecord['address'],
            _isdone
          ]);
        });

        print(doctormap);
      }
    }();
    print("HERE");
    print(doctormap);

    _isLoading = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> litems = ["1", "2", "Third", "4"];
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text('My Appointments'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? CircularProgressIndicator()
          : doctormap.length == 0
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Ink(
                              color: Color.fromRGBO(255, 255, 255, 0.4)
                                  .withOpacity(0.01),
                              child: ListTile(
                                leading: Column(
                                  children: [

                                    SizedBox(height:10),
                                    Text(DateFormat.MMM()
                                        .format(DateTime.now()
                                            .add(Duration(days: 1)))
                                        .toString()),
                                    Text(
                                      DateTime.now()
                                          .add(Duration(days: 1))
                                          .day
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                title: Text(doctormap[index][1]),
                                subtitle: Text(doctormap[index][3] +
                                    "-" +
                                    doctormap[index][2]),
                                trailing: doctormap[index][4] == "true"
                                    ? Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                  initialEntryMode:
                                                      TimePickerEntryMode.input)
                                              .then((pickedTime) {
                                            DateTime tomorrow = DateTime.now()
                                                .add(Duration(days: 1));
                                            DateTime appdate = DateTime(
                                                tomorrow.year,
                                                tomorrow.month,
                                                tomorrow.day,
                                                pickedTime!.hour,
                                                pickedTime.minute);
                                            print(appdate);
                                            FirebaseFirestore.instance
                                                .collection('appointments')
                                                .add({
                                              'patientEmail': RepositoryProvider
                                                      .of<SessionRepository>(
                                                          context)
                                                  .loggedinCustomer
                                                  .email,
                                              'time': appdate,
                                              'doctorEmail': doctormap[index][0]
                                            });
                                          });
                                          setState(() {
                                            doctormap[index][4] = "true";
                                          });
                                        },
                                        icon: Icon(Icons.alarm_on)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: doctormap.length,
                ),
    );
  }

}
