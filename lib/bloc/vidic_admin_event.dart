part of 'vidic_admin_bloc.dart';

abstract class VidicAdminEvent extends Equatable {
  const VidicAdminEvent();

  @override
  List<Object> get props => [];
}

class VidicInitialEvent extends VidicAdminEvent {}

class VidicLoginEvent extends VidicAdminEvent {
  String email;
  String password;
  VidicLoginEvent({required this.email, required this.password});
}

class LogoutEvent extends VidicAdminEvent {}

class TenantGetEvent extends VidicAdminEvent {}

class StatementGetEvent extends VidicAdminEvent {}

class InvoiceGetEvent extends VidicAdminEvent {}

class LetterGetEvent extends VidicAdminEvent {}

class OccupancyGetEvent extends VidicAdminEvent {}

class ComplaintGetEvent extends VidicAdminEvent {}
// ---------------------------------------------------------------

// create new tenant account

class CreateTenantEvent extends VidicAdminEvent {}

class CreateTenantDataEvent extends VidicAdminEvent {
  String name;
  String number;
  String officialEmail;
  String about;
  String? floor;
  String size;
  String rent;
  String escalation;
  String pobox;
  String leaseStartDate;
  String leaseEndDate;
  String active;
  CreateTenantDataEvent(
      {required this.name,
      required this.number,
      required this.officialEmail,
      required this.about,
      required this.floor,
      required this.size,
      required this.rent,
      required this.escalation,
      required this.pobox,
      required this.leaseStartDate,
      required this.leaseEndDate,
      required this.active});
}

// ---------------------------------------------------------------