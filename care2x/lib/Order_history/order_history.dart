import 'package:care2x/Order_history/Order_detail.dart';
import 'package:care2x/Order_history/subCategory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../session_repo.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: new AppBar(
        title: new Text('Order History'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
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
                            temp['email'] ||
                        temp['isComplete'] == false)
                      return SizedBox(
                        height: 0,
                      );
                    else
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Ink(
                          color:
                              Color.fromRGBO(58, 66, 86, 1.0).withOpacity(0.4),
                          child: ListTile(
                            subtitle: Text("Total Cost: Rs." +
                                temp['totalCost'].toString()),
                            title: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                OrderDetail(temp['orderDate']),
                                Container(
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SubCategoery(temp.id)),
                                      );
                                    },
                                    color: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Text(
                                      "Details",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                  });
            } else {
              return LinearProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
