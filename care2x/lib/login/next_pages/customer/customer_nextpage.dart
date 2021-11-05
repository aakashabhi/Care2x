import 'package:care2x/session_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'bloc/custdetails_bloc.dart';

final _formKey = GlobalKey<FormState>();

class CustNextPage extends StatelessWidget {
  const CustNextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "ADDITIONAL DETAILS",
            style: TextStyle(fontSize: 30),
          ),
          automaticallyImplyLeading: false),
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: BlocListener<CustdetailsBloc, CustdetailsState>(
          listener: (context, state) {
            if (state.status is UploadSuccessful) {
              RepositoryProvider.of<SessionRepository>(context)
                  .loggedinCustomer
                  .address = state.addressinput;
              RepositoryProvider.of<SessionRepository>(context)
                  .loggedinCustomer
                  .phonenumber = state.addressinput;
              print(RepositoryProvider.of<SessionRepository>(context)
                  .loggedinCustomer
                  .phonenumber);
              EasyLoading.showSuccess(
                'Account Successfully Created',
              );
            } else if (state.status is UploadingDetails) {
              EasyLoading.showProgress(
                0.3,
                status: 'Creating Account.....',
              );
            } else if (state.status is UploadFailed) {
              EasyLoading.showError('Failed with Error');
            }
          },
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 20, top: 40, right: 20, bottom: 20),
                  child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      maxLines: 4,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Enter Your Address",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.5),
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                      validator: (value) =>
                          value != null ? null : "Enter address",
                      onChanged: (value) => context.read<CustdetailsBloc>().add(
                            AddressChanged(address: value),
                          )),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: TextFormField(
                      obscureText: false,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Enter Your Phone Number",
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) =>
                          value!.length == 10 ? null : "Enter Valid Phone Num",
                      onChanged: (value) => context.read<CustdetailsBloc>().add(
                            PhoneChanged(phone: value),
                          ),
                    )),
                SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () {
                      print("pressed");
                      if (_formKey.currentState!.validate()) {
                        context.read<CustdetailsBloc>().add(ButtonClicked());
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.redAccent[700])),
                    child: Text("Click to Add Details"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
