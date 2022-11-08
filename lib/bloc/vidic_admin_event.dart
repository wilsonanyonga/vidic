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
