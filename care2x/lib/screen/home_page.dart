import 'package:flutter/material.dart';
import 'package:se_theory/list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        backgroundColor: Colors.redAccent ,
        elevation: 0.0,
        leading: Icon(Icons.sort),
        actions: [
          Padding(
            padding: const EdgeInsets.all(9.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('images/logo.png'),
              )
          )
        ],
      ),
      body: DocterList(),
    );

  }
}
// TextField(
// decoration: InputDecoration(
// hintText: "Search", hintStyle: TextStyle(color: Colors.black), prefixIcon: Icon(Icons.search,color: Colors.black ,),
// filled: true, fillColor: Colors.black12,
// border: OutlineInputBorder(borderSide: BorderSide.none,
// borderRadius: BorderRadius.circular(10)),
// ),



