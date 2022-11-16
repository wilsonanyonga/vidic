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

// ---------Tenant---------------------------
class TenantLoading extends VidicAdminState {}

class TenantLoaded extends VidicAdminState {
  List<DatumTenant> data;
  List<DatumOccupancy> occupy;
  TenantLoaded(this.data, this.occupy);

  @override
  // TODO: implement props
  List<Object> get props => [data, occupy];
}

// ---------STATEMENT END---------------------------

// ---------STATEMENT---------------------------
class StatementLoading extends VidicAdminState {}

class StatementLoaded extends VidicAdminState {
  List<Datum> data;
  StatementLoaded(this.data);

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

// ---------STATEMENT END---------------------------

// ---------INVOICE---------------------------

class InvoiceLoading extends VidicAdminState {}

class InvoiceLoaded extends VidicAdminState {
  List<DatumInvoice> data;
  InvoiceLoaded(this.data);

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

// ---------INVOICE END---------------------------

// ---------LETTER---------------------------

class LetterLoading extends VidicAdminState {}

class LetterLoaded extends VidicAdminState {
  List<DatumLetter> data;
  LetterLoaded(this.data);

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

// ---------LETTER END---------------------------

// ---------LETTER complaint---------------------------

class ComplaintLoading extends VidicAdminState {}

class ComplaintLoaded extends VidicAdminState {
  List<DatumTenantLetter> data;
  ComplaintLoaded(this.data);

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

// ---------LETTER complaint END---------------------------

// ---------Occupancy---------------------------

class OccupancyLoading extends VidicAdminState {}

class OccupancyLoaded extends VidicAdminState {
  List<DatumOccupancy> data;
  OccupancyLoaded(this.data);

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

// ---------Occupancy END---------------------------

// ---------------------------------------------------------------------------------------------

// ------ CREATE NEW TENANT -----------------------

class CreateTenantState extends VidicAdminState {
  int loadingButton;
  CreateTenantState(this.loadingButton);
  @override
  // TODO: implement props
  List<Object> get props => [loadingButton];
}

class TenantBackOption extends VidicAdminState {}

// ------ CREATE NEW Statemnt -----------------------
class CreateStatementState extends VidicAdminState {
  int loadingButton;
  String? fileName;
  List<DropdownMenuItem<String>> dropdownItems;
  CreateStatementState(this.loadingButton, this.fileName, this.dropdownItems);
  @override
  // TODO: implement props
  List<Object> get props => [loadingButton, fileName!, dropdownItems];
}

class StatementBackOption extends VidicAdminState {}

// ---------------------------------------------------------------------------------------------

// ------ CREATE NEW Invoice -----------------------

class CreateInvoiceState extends VidicAdminState {
  int loadingButton;
  List<DropdownMenuItem<String>> dropdownItems;
  String invoiceFileName;
  CreateInvoiceState(
    this.loadingButton,
    this.invoiceFileName,
    this.dropdownItems,
  );
  @override
  // TODO: implement props
  List<Object> get props => [loadingButton, invoiceFileName, dropdownItems];
}

class InvoiceBackOption extends VidicAdminState {}

// ---------------------------------------------------------------------------------------------

// ------ CREATE NEW Letter -----------------------

class CreateLetterState extends VidicAdminState {
  int loadingButton;
  List<DropdownMenuItem<String>> dropdownItems;
  String letterFileName;
  CreateLetterState(
    this.loadingButton,
    this.letterFileName,
    this.dropdownItems,
  );
  @override
  // TODO: implement props
  List<Object> get props => [loadingButton, letterFileName, dropdownItems];
}

class LetterBackOption extends VidicAdminState {}

// ---------------------------------------------------------------------------------------------

// ------ CREATE NEW Occupancy -----------------------

// CreateOccupancyEvent
class CreateOccupancyState extends VidicAdminState {}
