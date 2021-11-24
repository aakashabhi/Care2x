import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SubCategoery extends StatefulWidget {
  final doc;
  SubCategoery(this.doc);

  @override
  _SubCategoryClassState createState() => _SubCategoryClassState();
}

class _SubCategoryClassState extends State<SubCategoery> {
  final db = FirebaseFirestore.instance;
  Map<String, Map<String, dynamic>> productInfo = {};
  bool _isConnected = false;
  @override
  void initState() {
    () async {
      var collection = FirebaseFirestore.instance.collection('products');
      var querySnapshots = await collection.get();
      for (var snapshot in querySnapshots.docs) {
        var documentID = snapshot.id;
        var x = snapshot.data();
        Map<String, dynamic> info = {};
        info['description'] = x['description'];
        info['name'] = x['name'];
        info['price'] = x['price'];
        productInfo[documentID] = info;
      }
      setState(() {
        _isConnected = true;
      });
    }();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          title: Text("Ordered Items"),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        ),
        body: (_isConnected == true)
            ? StreamBuilder<QuerySnapshot>(
                stream: db
                    .collection('orders')
                    .doc(widget.doc)
                    .collection('items')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return new ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var temp = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Ink(
                                color: Color.fromRGBO(58, 66, 86, 1.0)
                                    .withOpacity(0.4),
                                child: ListTile(
                                  subtitle: Text("Quantity: " +
                                      temp['quantity'].toString()),
                                  title: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        productInfo[temp['productId']
                                                .toString()]!['name']
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Rs. " +
                                            productInfo[temp['productId']
                                                    .toString()]!['price']
                                                .toString() +
                                            " per unit",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return LinearProgressIndicator();
                  }
                },
              )
            : LinearProgressIndicator());
  }
}
