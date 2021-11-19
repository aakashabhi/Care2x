import 'package:care2x/login/login_screen.dart';
import 'package:care2x/login/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  Widget button(
      String name, Color Color, Color textColor, BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          if (name == "Login") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LoginPage(),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SignUp(),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0).withOpacity(0.5),
        body: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: Container(
                child: Center(
                  child: Image.network("https://i.ibb.co/sRNjqBL/unnamed.png"),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Welcome To Care2X",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    button("Login", Colors.redAccent, Colors.white, context),
                    button("Sign up", Colors.white, Colors.white, context),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
