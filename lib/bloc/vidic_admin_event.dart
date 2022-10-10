part of 'vidic_admin_bloc.dart';

abstract class VidicAdminEvent extends Equatable {
  const VidicAdminEvent();

  @override
  List<Object> get props => [];
}

class VidicLoginEvent extends VidicAdminEvent {}
