import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubCategoery extends StatefulWidget {
  final doc;
  SubCategoery(this.doc);

  @override
  _SubCategoryClassState createState() => _SubCategoryClassState();
}

//Map<string,Map<dynamic,dynamic>>

class _SubCategoryClassState extends State<SubCategoery> {
  final db = FirebaseFirestore.instance;
  Map<String, Map<String, dynamic>> productInfo = {};

  @override
  void initState() {
    () async {
      var collection = FirebaseFirestore.instance.collection('products');
      var querySnapshots = await collection.get();
      for (var snapshot in querySnapshots.docs) {
        var documentID = snapshot.id; // <-- Document ID
        var x = snapshot.data();
        print("**********");
        print(documentID);
        Map<String, dynamic> info = {};
        info['description'] = x['description'];
        info['name'] = x['name'];
        info['price'] = x['price'];
        productInfo[documentID] = info;
        print("**********");
      }
      setState(() {});
    }();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ordered Items"),
        centerTitle: true,
      ),
      body: new StreamBuilder<QuerySnapshot>(
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
                      child: ListTile(
                        title: Column(
                          children: <Widget>[
                            Text(temp['quantity'].toString()),
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
            return LinearProgressIndicator();
          }
        },
      ),
    );
  }
}
