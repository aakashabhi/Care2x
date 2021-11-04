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
                color: Colors.blue,
                size: 50.0,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              elevation: 0.0,
              title: Text('Add Remedy'),
            ),
            body: Container(
              color: Colors.blue[50],
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
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
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
