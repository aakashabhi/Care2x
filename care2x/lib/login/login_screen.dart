import 'package:care2x/ViewRemedies/view_remedy.dart';
import 'package:care2x/screens/customer_screen.dart';
import 'package:care2x/screens/doctor_screen.dart';
import 'package:care2x/login/signup.dart';
import 'package:care2x/view_appointments/view_appointments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../session_repo.dart';
import 'models/customer.dart';
import 'models/doctor.dart';
import 'mytextfield.dart';

class LoginPage extends StatefulWidget {
  static String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loadding = false;
  RegExp regExp = RegExp(LoginPage.pattern);
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  late UserCredential userCredential;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future loginAuth() async {
    try {
      print(email.text);
      print(password.text);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      print(userCredential.user!.uid);

      var coll = await FirebaseFirestore.instance
          .collection('userData')
          .where("email", isEqualTo: email.text)
          .get();
      var correctrecord = coll.docs.map((doc) => doc.data()).toList()[0];
      print("heee");
      print(coll.docs.map((doc) => doc.data()).toList()[0]);

      if (correctrecord['isDoctor'] == true) {
        var doccoll = await FirebaseFirestore.instance
            .collection('doctors')
            .where("email", isEqualTo: email.text)
            .get();
        var correctdocrecord =
            doccoll.docs.map((doc) => doc.data()).toList()[0];
        print(correctdocrecord);
        RepositoryProvider.of<SessionRepository>(context).loggedinDoctor =
            Doctor(
                email: correctrecord['email'],
                firstname: correctrecord['firstName'],
                lastname: correctrecord['lastName'],
                specialisation: correctdocrecord['specialisation'],
                phoneno: correctdocrecord['phone'],
                hospitaladdress: correctdocrecord['address']);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DoctorScreen(),
          ),
        );
      } else if (correctrecord['isVendor'] == true) {
        // TODO: Push Vendor Screen and data visible
      } else {
        var custcoll = await FirebaseFirestore.instance
            .collection('customers')
            .where("email", isEqualTo: email.text)
            .get();
        var correctcustrecord =
            custcoll.docs.map((doc) => doc.data()).toList()[0];
        RepositoryProvider.of<SessionRepository>(context).loggedinCustomer =
            Customer(
                firstname: correctrecord['firstName'],
                lastname: correctrecord['lastName'],
                email: correctrecord['email'],
                address: correctcustrecord['address'],
                phonenumber: correctcustrecord['phone']);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CustomerScreen(),
          ),
        );
      }

      globalKey.currentState!.showSnackBar(
        SnackBar(content: Text('Login Success'), backgroundColor: Colors.green),
      );

      print("Success");
      print("Success");
    } on FirebaseAuthException catch (e) {
      print("DED");
      if (e.code == 'user-not-found') {
        globalKey.currentState!.showSnackBar(
          SnackBar(
              content: Text('No user found for that email.'),
              backgroundColor: Colors.red),
        );
      } else if (e.code == 'wrong-password') {
        globalKey.currentState!.showSnackBar(
          SnackBar(
              content: Text('Wrong password!.'), backgroundColor: Colors.red),
        );
        setState(() {
          loadding = false;
        });
      }
      setState(() {
        loadding = false;
      });
    }
  }

  void validation() {
    if (email.text.trim().isEmpty ||
        email.text.trim() == null && password.text.trim().isEmpty ||
        password.text.trim() == null) {
      // ignore: deprecated_member_use
      globalKey.currentState!.showSnackBar(
        SnackBar(
            content: Text("All Fields are Empty"), backgroundColor: Colors.red),
      );
    }
    if (email.text.trim().isEmpty || email.text.trim() == null) {
      // ignore: deprecated_member_use
      globalKey.currentState!.showSnackBar(
        SnackBar(content: Text("Email is Empty"), backgroundColor: Colors.red),
      );
      return;
    } else if (!regExp.hasMatch(email.text)) {
      globalKey.currentState!.showSnackBar(
        SnackBar(
            content: Text(
              "Please enter vaild Email",
            ),
            backgroundColor: Colors.red),
      );
      return;
    }
    if (password.text.trim().isEmpty || password.text.trim() == null) {
      globalKey.currentState!.showSnackBar(
        SnackBar(
            content: Text("Password is Empty"), backgroundColor: Colors.red),
      );
      return;
    } else {
      setState(() {
        loadding = true;
      });
      loginAuth();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,automaticallyImplyLeading: false,      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 170),
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                MyTextField(
                  controller: email,
                  obscureText: false,
                  hintText: 'Email',
                ),
                SizedBox(
                  height: 30,
                ),
                MyTextField(
                  controller: password,
                  obscureText: true,
                  hintText: 'Password',
                ),
              ],
            ),
            loadding
                ? CircularProgressIndicator()
                : Container(
                    height: 60,
                    width: 200,
                    child: RaisedButton(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: validation,
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New user?",
                  style: TextStyle(color: Colors.grey),
                ),
                FlatButton(
                    child: Text("Register now.",
                        style: TextStyle(color: Colors.red)),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SignUp(),
                        ),
                      );
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
