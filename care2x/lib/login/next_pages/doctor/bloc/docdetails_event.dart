part of 'docdetails_bloc.dart';

@immutable
abstract class DocdetailsEvent {}

class SpecialisationChanged extends DocdetailsEvent {
  String specialisation;
  SpecialisationChanged({required this.specialisation});
}

class AddressChanged extends DocdetailsEvent {
  String address;
  AddressChanged({required this.address});
}

class PhoneChanged extends DocdetailsEvent {
  String phone;
  PhoneChanged({required this.phone});
}

class ButtonClicked extends DocdetailsEvent {}
