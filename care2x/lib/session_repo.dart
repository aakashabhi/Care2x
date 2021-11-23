import 'package:cloud_firestore/cloud_firestore.dart';

import 'login/models/customer.dart';
import 'login/models/doctor.dart';

class SessionRepository {
  late bool isdoctor;
  late Customer loggedinCustomer;
  late List<Map<dynamic, dynamic>> doctorappointments;
  late Doctor loggedinDoctor;

  Future<void> getappointments() async {
    print(loggedinDoctor.email);
    var custcoll = await FirebaseFirestore.instance
        .collection('appointments')
        .where("doctorEmail", isEqualTo: loggedinDoctor.email)
        .get();
    List<Map<dynamic, dynamic>> appointments =
        custcoll.docs.map((doc) => doc.data()).toList();
    doctorappointments = appointments
        .where((element) =>
            element['doctorEmail'] == loggedinDoctor.email &&
            element['time'].toDate().day == DateTime.now().day)
        .toList();

    print(doctorappointments);
  }
}
