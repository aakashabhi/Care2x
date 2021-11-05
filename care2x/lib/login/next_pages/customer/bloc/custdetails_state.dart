part of 'custdetails_bloc.dart';

class CustdetailsState {
  final String addressinput;
  final String phonenumber;
  final AddDetailsState status;

  CustdetailsState(
      {required this.addressinput,
      required this.phonenumber,
      required this.status});
  CustdetailsState copyWith(
      String? addressinput, String? phonenumber, AddDetailsState? status) {
    return CustdetailsState(
        addressinput: addressinput as String,
        phonenumber: phonenumber as String,
        status: status as AddDetailsState);
  }
}

@immutable
abstract class AddDetailsState {
  const AddDetailsState();
}

class InitialStatus extends AddDetailsState {
  const InitialStatus();
}

class UploadingDetails extends AddDetailsState {}

class UploadSuccessful extends AddDetailsState {}

class UploadFailed extends AddDetailsState {
  final String exception;
  UploadFailed({required this.exception});
}
