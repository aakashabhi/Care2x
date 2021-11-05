part of 'docdetails_bloc.dart';

class DocdetailsState {
  final String specialisation;
  final String addressinput;
  final String phonenumber;
  final AddDetailsState status;

  DocdetailsState(
      {required this.specialisation,
      required this.addressinput,
      required this.phonenumber,
      required this.status});
  DocdetailsState copyWith(String? specialisation, String? addressinput,
      String? phonenumber, AddDetailsState? status) {
    return DocdetailsState(
        specialisation: specialisation as String,
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
