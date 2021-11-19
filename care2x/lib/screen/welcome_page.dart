import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se_theory/screen/home_page.dart';



class WelcomePage extends StatelessWidget {
  Widget button(String name,Color Color, Color textColor,){
    return  Container(
      width: 300,
      height: 60,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius : BorderRadius.circular(30)), ),
        child: Text(name,style: TextStyle(color: textColor)),
      ),
    );
  }

  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => HomePage())
            );
          },icon: Icon(Icons.add),)
        ],
      ),
      body:Column(
        children: [
          Expanded(
              child:Container(
                child: Center(
                  child: Image.asset('images/logo3.png'),
                ),
              ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Welcome To Care2X",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                      ),
                  ),
                  Column(
                    children: [
                      Text("Books your appointments and"),
                      Text("Order Medicines Online!"),
                    ],
                  ),
                  button("Login", Colors.redAccent, Colors.white,),
                  button("Sign up",Colors.white,Colors.black,),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
