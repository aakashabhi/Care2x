import 'package:care2x/ViewRemedies/remedy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Remedy_description.dart';

class RemedyList extends StatefulWidget {
  const RemedyList({Key? key}) : super(key: key);

  @override
  _RemedyListState createState() => _RemedyListState();
}

class _RemedyListState extends State<RemedyList> {
  @override
  Widget build(BuildContext context) {
    final remedies = Provider.of<List<Remedy>>(context);
    void _showDescriptionPanel(Remedy Rem) {
      showModalBottomSheet(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          context: context,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height * 2,
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: Description(rem: Rem),
            );
          },
          backgroundColor: Color.fromRGBO(255,255,255, 1.0).withOpacity(0.85));
    }

    return ListView.builder(
        itemCount: remedies.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Ink(
              color:Color.fromRGBO(58, 66, 86, 1.0).withOpacity(0.4),
              child: ListTile(
                onTap: () {
                  _showDescriptionPanel(remedies[index]);
                },
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      remedies[index].title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: MaterialButton(
                        onPressed: () => _showDescriptionPanel(remedies[index]),
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          "View Remedy",
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
  }
}
