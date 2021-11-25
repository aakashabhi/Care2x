import 'package:care2x/login/next_pages/customer/customer_nextpage.dart';
import 'package:care2x/login/next_pages/doctor/doctor_nextpage.dart';
import 'package:care2x/session_repo.dart';
import 'package:care2x/vendor/ui/presentation/vendor_home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'models/customer.dart';
import 'models/doctor.dart';
import 'mytextfield.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'next_pages/customer/bloc/custdetails_bloc.dart';
import 'next_pages/doctor/bloc/docdetails_bloc.dart';

class SignUp extends StatefulWidget {
  static String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  late UserCredential userCredential;
  RegExp regExp = RegExp(SignUp.pattern);
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  late bool isDoctor;
  late bool isVendor;

  Future sendData() async {
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      var coll = await FirebaseFirestore.instance.collection('userData');

      await coll.doc(userCredential.user!.uid).set({
        "firstName": firstName.text.trim(),
        "lastName": lastName.text.trim(),
        "email": email.text.trim(),
        "userid": userCredential.user!.uid,
        "password": password.text.trim(),
        "isDoctor": isDoctor,
        "isVendor": isVendor
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Added Account Successfully"),
            backgroundColor: Colors.green),
      );
      if (isDoctor == false && isVendor == false) {
        RepositoryProvider.of<SessionRepository>(context).loggedinCustomer =
            Customer(
                firstname: firstName.text.trim(),
                lastname: lastName.text.trim(),
                email: email.text.trim(),
                address: "",
                phonenumber: "");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => CustdetailsBloc(email: email.text.trim()),
              child: CustNextPage(),
            ),
          ),
        );
      } else if (isDoctor == true && isVendor == false) {
        RepositoryProvider.of<SessionRepository>(context).loggedinDoctor =
            Doctor(
                firstname: firstName.text.trim(),
                lastname: lastName.text.trim(),
                email: email.text.trim(),
                hospitaladdress: "",
                specialisation: "",
                phoneno: "");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => DocdetailsBloc(email: email.text.trim()),
              child: DoctorNextPage(),
            ),
          ),
        );
      } else if (isVendor == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VendorHomePage(
              vendorId: userCredential.user!.uid.toString(),
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("The password provided is too weak."),
              backgroundColor: Colors.red),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("The account already exists for that email"),
              backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e as String), backgroundColor: Colors.red),
      );
      setState(() {
        loading = false;
      });
    }
    setState(() {
      loading = false;
    });
  }

  void validation() {
    if (firstName.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              "First Name is Empty",
            ),
            backgroundColor: Colors.red),
      );
      return;
    }
    if (lastName.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              "Last Name is Empty",
            ),
            backgroundColor: Colors.red),
      );
      return;
    }
    if (email.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              "Email is Empty",
            ),
            backgroundColor: Colors.red),
      );
      return;
    } else if (!regExp.hasMatch(email.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              "Please enter vaild Email",
            ),
            backgroundColor: Colors.red),
      );
      return;
    }
    if (password.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              "Password is Empty",
            ),
            backgroundColor: Colors.red),
      );
      return;
    } else {
      setState(() {
        loading = true;
      });
      sendData();
    }
  }

  Widget button(
      {required String buttonName,
      required Color color,
      required Color textColor,
      required Function ontap}) {
    return Container(
      width: 150,
      child: RaisedButton(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          buttonName,
          style: TextStyle(fontSize: 16, color: textColor),
        ),
        onPressed: () {
          ontap();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              Container(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTextField(
                      controller: firstName,
                      obscureText: false,
                      hintText: 'Enter Your First Name',
                    ),
                    MyTextField(
                      controller: lastName,
                      obscureText: false,
                      hintText: 'Enter Your Last Name',
                    ),
                    MyTextField(
                      controller: email,
                      obscureText: false,
                      hintText: 'Email',
                    ),
                    MyTextField(
                      controller: password,
                      obscureText: true,
                      hintText: 'Password',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Register As",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        ToggleSwitch(
                          initialLabelIndex: 0,
                          totalSwitches: 3,
                          minWidth: 65,
                          labels: ['Doctor', 'Customer', 'Retailer'],
                          activeBgColor: [Colors.white],
                          activeFgColor: Colors.black,
                          inactiveBgColor: Colors.grey,
                          inactiveFgColor: Colors.grey[900],
                          onToggle: (index) {
                            if (index == 0) {
                              isDoctor = true;
                              isVendor = false;
                            } else if (index == 1) {
                              isDoctor = false;
                              isVendor = false;
                            } else if (index == 2) {
                              isDoctor = false;
                              isVendor = true;
                            }
                          },
                          fontSize: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              loading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        button(
                          ontap: () {
                            validation();
                          },
                          buttonName: "Register Now!",
                          color: Colors.red,
                          textColor: Colors.white,
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
