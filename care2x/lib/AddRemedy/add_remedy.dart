import 'package:care2x/AddRemedy/text_decor.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddRemedy extends StatefulWidget {
  const AddRemedy({Key? key}) : super(key: key);

  @override
  _AddRemedyState createState() => _AddRemedyState();
}

class _AddRemedyState extends State<AddRemedy> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return (loading == true)
        ? Container(
            color: Colors.blue,
            child: Center(
              child: SpinKitChasingDots(
                color: Color.fromRGBO(58, 66, 86, 1.0),
                size: 50.0,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text('Add Remedy'),
              backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
              automaticallyImplyLeading: false,
            ),
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
            body: Container(
              color: Color.fromRGBO(58, 66, 86, 0.05),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Title'),
                      validator: (val) => (val == null || val.length == 0)
                          ? 'Enter a Title'
                          : null,
                      onChanged: (val) {
                        setState(() => title = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Description'),
                      validator: (val) => (val == null || val.length == 0)
                          ? 'Enter a Title'
                          : null,
                      onChanged: (val) {
                        setState(() => description = val);
                      },
                      maxLines: 5,
                    ),
                    SizedBox(height:40.0),
                    ElevatedButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            print('***********');
                            print(title);
                            print(description);
                            print('***********');

                            Map<String, String> data = {
                              "Title": title,
                              "Description": description
                            };
                            FirebaseFirestore.instance
                                .collection('QuickRemedies')
                                .add(data);
                            setState(() {
                              loading = false;
                            });
                          }
                        }),
                  ],
                ),
              ),
            ),
          );
  }
}
