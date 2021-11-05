
import 'package:bloc/bloc.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'custdetails_event.dart';
part 'custdetails_state.dart';

class CustdetailsBloc extends Bloc<CustdetailsEvent, CustdetailsState> {
  final String email;
  CustdetailsBloc({required this.email})
      : super(CustdetailsState(
          addressinput: "",
          phonenumber: "",
          status: InitialStatus(),
        ));
  @override
  Stream<CustdetailsState> mapEventToState(CustdetailsEvent event) async* {
    if (event is AddressChanged) {
      yield state.copyWith(event.address, state.phonenumber, state.status);
    } else if (event is PhoneChanged) {
      yield state.copyWith(state.addressinput, event.phone, state.status);
    } else if (event is ButtonClicked) {
      yield state.copyWith(
          state.addressinput, state.phonenumber, UploadingDetails());
      try {
        var coll = await FirebaseFirestore.instance.collection('customers');

        await coll.doc().set({
          'email': email,
          'address': state.addressinput,
          'phone': state.phonenumber
        });
        yield state.copyWith(
            state.addressinput, state.phonenumber, UploadSuccessful());
      } on Exception catch (e) {
        yield state.copyWith(state.addressinput, state.phonenumber,
            UploadFailed(exception: "Upload Failed"));
      }
    }
  }
}
