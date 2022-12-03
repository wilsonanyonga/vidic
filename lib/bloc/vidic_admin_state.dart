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
  final String? message;
  const LoginError(this.message);

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [message!];
}

// ---------Tenant---------------------------
class TenantLoading extends VidicAdminState {}

class TenantLoadingFailed extends VidicAdminState {}

class TenantLoaded extends VidicAdminState {
  final List<DatumTenant> data;
  final List<DatumOccupancy> occupy;
  const TenantLoaded(this.data, this.occupy);

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [data, occupy];
}

// ---------STATEMENT END---------------------------

// ---------STATEMENT---------------------------
class StatementLoading extends VidicAdminState {}

class StatementLoadingFailed extends VidicAdminState {}

class StatementLoaded extends VidicAdminState {
  final List<Datum> data;
  const StatementLoaded(this.data);

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [data];
}

// ---------STATEMENT END---------------------------

// ---------INVOICE---------------------------

class InvoiceLoading extends VidicAdminState {}

class InvoiceLoadingFailed extends VidicAdminState {}

class InvoiceLoaded extends VidicAdminState {
  final List<DatumInvoice> data;
  const InvoiceLoaded(this.data);

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [data];
}

// ---------INVOICE END---------------------------

// ---------LETTER---------------------------

class LetterLoading extends VidicAdminState {}

class LetterLoadingFailed extends VidicAdminState {}

class LetterLoaded extends VidicAdminState {
  final List<DatumLetter> data;
  const LetterLoaded(this.data);

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [data];
}

// ---------LETTER END---------------------------

// ---------LETTER complaint---------------------------

class ComplaintLoading extends VidicAdminState {}

class ComplaintLoadingFailed extends VidicAdminState {}

class ComplaintLoaded extends VidicAdminState {
  final List<DatumTenantLetter> data;
  const ComplaintLoaded(this.data);

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [data];
}

// ---------LETTER complaint END---------------------------

// ---------Occupancy---------------------------

class OccupancyLoading extends VidicAdminState {}

class OccupancyLoadingFailed extends VidicAdminState {}

class OccupancyLoaded extends VidicAdminState {
  final List<DatumOccupancy> data;
  const OccupancyLoaded(this.data);

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [data];
}

// ---------Occupancy END---------------------------

// ---------------------------------------------------------------------------------------------

// ------ CREATE NEW TENANT -----------------------

class CreateTenantState extends VidicAdminState {
  final int loadingButton;
  const CreateTenantState(this.loadingButton);
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [loadingButton];
}

class TenantBackOption extends VidicAdminState {}

// ------ CREATE NEW Statemnt -----------------------
class CreateStatementState extends VidicAdminState {
  final int loadingButton;
  final String? fileName;
  final List<DropdownMenuItem<String>> dropdownItems;
  const CreateStatementState(
      this.loadingButton, this.fileName, this.dropdownItems);
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [loadingButton, fileName!, dropdownItems];
}

class StatementBackOption extends VidicAdminState {}

// ---------------------------------------------------------------------------------------------

// ------ CREATE NEW Invoice -----------------------

class CreateInvoiceState extends VidicAdminState {
  final int loadingButton;
  final List<DropdownMenuItem<String>> dropdownItems;
  final String invoiceFileName;
  const CreateInvoiceState(
    this.loadingButton,
    this.invoiceFileName,
    this.dropdownItems,
  );
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [loadingButton, invoiceFileName, dropdownItems];
}

class InvoiceBackOption extends VidicAdminState {}

// ---------------------------------------------------------------------------------------------

// ------ CREATE NEW Letter -----------------------

class CreateLetterState extends VidicAdminState {
  final int loadingButton;
  final List<DropdownMenuItem<String>> dropdownItems;
  final String letterFileName;
  const CreateLetterState(
    this.loadingButton,
    this.letterFileName,
    this.dropdownItems,
  );
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [loadingButton, letterFileName, dropdownItems];
}

class LetterBackOption extends VidicAdminState {}

// ---------------------------------------------------------------------------------------------

// ------ CREATE NEW Occupancy -----------------------

// CreateOccupancyEvent
class UpdateOccupancyState extends VidicAdminState {
  final int floorId;
  final String occupancy;
  final String capacity;
  final int loadingButton;

  const UpdateOccupancyState(
    this.floorId,
    this.occupancy,
    this.capacity,
    this.loadingButton,
  );

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [floorId, occupancy, capacity, loadingButton];
}

class OccupancyBackOption extends VidicAdminState {}

// ---------------------------------------------------------------------------------------------

// ------ Update Letters -----------------------

// display the update page and pass parametters
class UpdateLettersPatchState extends VidicAdminState {
  final int? id;
  final String subject;
  final int loadingButton;
  final String letterUpdateFileName;

  const UpdateLettersPatchState(
    this.id,
    this.subject,
    this.loadingButton,
    this.letterUpdateFileName,
  );

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [id!, subject, loadingButton, letterUpdateFileName];
}

class UpdateLetterBackOption extends VidicAdminState {}

// ------ Update Invoices -----------------------

// display the invoices update page and pass parametters
class UpdateInvoicesState extends VidicAdminState {
  final int? id;
  final String? amount;
  final String? purpose;
  final String? invoiceMonth;
  final String letterUpdateFileName;
  final int loadingButton;

  const UpdateInvoicesState(
    this.id,
    this.amount,
    this.purpose,
    this.invoiceMonth,
    this.letterUpdateFileName,
    this.loadingButton,
  );

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [
        id!,
        amount!,
        purpose!,
        invoiceMonth!,
        letterUpdateFileName,
        loadingButton,
      ];
}

class UpdateInvoiceBackOption extends VidicAdminState {}

// ---------------------------------------------------
// ------ Update Statement ---------------------------
// ---------------------------------------------------

// display the invoices update page and pass parametters
class UpdateStatementsState extends VidicAdminState {
  // int? id;
  final String? amount;
  final DateTime? startDate;
  final DateTime? endDate;
  final String statementUpdateFileName;
  final int loadingButton;

  const UpdateStatementsState(
    // this.id,
    this.amount,
    this.startDate,
    this.endDate,
    this.statementUpdateFileName,
    this.loadingButton,
  );

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [
        // id!,
        amount!,
        startDate!,
        endDate!,
        statementUpdateFileName,
        loadingButton,
      ];
}

class UpdateStatementBackOption extends VidicAdminState {}

// CreateStatementUpdateStartDateEvent

// ---------------------------------------------------
//-------------- update tenant ------------------------
// ---------------------------------------------------

// UpdateTenantEvent
class UpdateTenantState extends VidicAdminState {
  // int? id;
  // String? amount;
  // DateTime? startDate;
  // DateTime? endDate;
  // String statementUpdateFileName;

  //  int id;
  final String? name;
  final String? number;
  final String? officialEmail;
  final String? about;
  final String? floor;
  final String? size;
  final String? rent;
  final String? escalation;
  final String? pobox;
  final DateTime? leaseStartDate;
  final DateTime? leaseEndDate;
  final String? active;
  final int loadingButton;

  const UpdateTenantState(
    // this.id,
    this.name,
    this.number,
    this.officialEmail,
    this.about,
    this.floor,
    this.size,
    this.rent,
    this.escalation,
    this.pobox,
    this.leaseStartDate,
    this.leaseEndDate,
    this.active,
    this.loadingButton,
  );

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [
        // id!,
        name!,
        number!,
        officialEmail!,
        about!,
        floor!,
        size!,
        rent!,
        escalation!,
        pobox!,
        leaseStartDate!,
        leaseEndDate!,
        active!,
        loadingButton,
      ];
}

class UpdateTenantBackOption extends VidicAdminState {}

// ---------------------------------------------------
//-------------- delete letter------------------------
// ---------------------------------------------------
// DeleteLetterEvent
class DeleteLetterRequestState extends VidicAdminState {}

class DeleteLetterSuccessState extends VidicAdminState {}

class DeleteLetterSuccessLoadingState extends VidicAdminState {}

// ---------------------------------------------------
//-------------- delete invoice------------------------
// ---------------------------------------------------
// DeleteLetterEvent
class DeleteInvoiceRequestState extends VidicAdminState {}

class DeleteInvoiceSuccessState extends VidicAdminState {}

class DeleteInvoiceSuccessLoadingState extends VidicAdminState {}

// ---------------------------------------------------
//-------------- delete statement ------------------------
// ---------------------------------------------------
// DeleteLetterEvent
class DeleteStatementRequestState extends VidicAdminState {}

class DeleteStatementSuccessState extends VidicAdminState {}

class DeleteStatementSuccessLoadingState extends VidicAdminState {}

// ---------------------------------------------------
//-------------- delete tenant ------------------------
// ---------------------------------------------------
// DeleteLetterEvent
class DeleteTenantRequestState extends VidicAdminState {}

class DeleteTenantSuccessState extends VidicAdminState {}

class DeleteTenantSuccessLoadingState extends VidicAdminState {}
