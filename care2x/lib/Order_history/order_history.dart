import 'package:care2x/Order_history/subCategory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../session_repo.dart';

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
        title: new Text('Order History'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: db.collection('orders').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var temp = snapshot.data!.docs[index];
                    if (RepositoryProvider.of<SessionRepository>(context)
                            .loggedinCustomer
                            .email !=
                        temp['email'])
                      return SizedBox(
                        height: 0,
                      );
                    else
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            print("**************");
                            print(temp.id);
                            print(RepositoryProvider.of<SessionRepository>(
                                    context)
                                .loggedinCustomer
                                .email);
                            print("**************");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SubCategoery(temp.id)),
                            );
                          },
                          child: ListTile(
                            title: Column(
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
