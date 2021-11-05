part of 'custdetails_bloc.dart';

@immutable
abstract class CustdetailsEvent {}

class AddressChanged extends CustdetailsEvent {
  String address;
  AddressChanged({required this.address});
}

class PhoneChanged extends CustdetailsEvent {
  String phone;
  PhoneChanged({required this.phone});
}

class ButtonClicked extends CustdetailsEvent {}
