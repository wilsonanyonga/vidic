part of 'vidic_admin_bloc.dart';

abstract class VidicAdminState extends Equatable {
  const VidicAdminState();

  @override
  List<Object> get props => [];
}

class VidicAdminInitial extends VidicAdminState {}

class LoginState extends VidicAdminState {}

class LoginLoading extends VidicAdminState {}

class LoginError extends VidicAdminState {
  String? message;
  LoginError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message!];
}
