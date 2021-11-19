import 'package:care2x/ViewRemedies/remedy.dart';
import 'package:care2x/ViewRemedies/remedy_list.dart';
import 'package:care2x/ViewRemedies/service.dart';
import 'package:care2x/view_products/productsgrid.dart';
import 'package:care2x/view_products/viewproducts_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewRemedy extends StatefulWidget {
  const ViewRemedy({Key? key}) : super(key: key);

  @override
  _ViewRemedyState createState() => _ViewRemedyState();
}

class _ViewRemedyState extends State<ViewRemedy> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Remedy>?>.value(
      initialData: [],
      value: DatabaseService().all_remedies,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          title: Text('Remedies'),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ViewProductsScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: RemedyList(),
        ),
      ),
    );
  }
}
