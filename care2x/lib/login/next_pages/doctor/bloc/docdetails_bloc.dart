import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'docdetails_event.dart';
part 'docdetails_state.dart';

class DocdetailsBloc extends Bloc<DocdetailsEvent, DocdetailsState> {
  final String email;
  DocdetailsBloc({required this.email})
      : super(DocdetailsState(
          specialisation: "",
          addressinput: "",
          phonenumber: "",
          status: InitialStatus(),
        ));
  @override
  Stream<DocdetailsState> mapEventToState(DocdetailsEvent event) async* {
    if (event is AddressChanged) {
      yield state.copyWith(
          state.specialisation, event.address, state.phonenumber, state.status);
    } else if (event is SpecialisationChanged) {
      yield state.copyWith(event.specialisation, state.addressinput,
          state.phonenumber, state.status);
    } else if (event is PhoneChanged) {
      yield state.copyWith(
          state.specialisation, state.addressinput, event.phone, state.status);
    } else if (event is ButtonClicked) {
      print(state.addressinput);
      print(state.phonenumber);
      print(state.specialisation);
      yield state.copyWith(state.specialisation, state.addressinput,
          state.phonenumber, UploadingDetails());
      try {
        var coll = await FirebaseFirestore.instance.collection('doctors');

        await coll.doc().set({
          'email': email,
          'address': state.addressinput,
          'phone': state.phonenumber,
          'specialisation': state.specialisation
        });
        yield state.copyWith(state.specialisation, state.addressinput,
            state.phonenumber, UploadSuccessful());
      } on Exception catch (e) {
        yield state.copyWith(state.specialisation, state.addressinput,
            state.phonenumber, UploadFailed(exception: "Upload Failed"));
      }
    }
  }
}
