import 'package:care2x/Order_history/subCategory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Collection Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: db.collection('orders').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var temp = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(0),
                      child: Card(
                        child: GestureDetector(
                          onTap: () {
                            print("**************");
                            print(temp.id);
                            print("**************");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SubCategoery(temp.id)),
                            );
                          },
                          child: Column(
                            children: <Widget>[
                              Text(temp['email']),
                              SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Text('Loading');
            }
          },
        ),
      ),
    );
  }
}
