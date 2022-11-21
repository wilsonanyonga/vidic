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

class CreateFloorEvent extends VidicAdminEvent {
  String? floor;
  CreateFloorEvent({required this.floor});
}

class CreateStartDateEvent extends VidicAdminEvent {
  String? startDate;
  CreateStartDateEvent({required this.startDate});
}

class CreateEndDateEvent extends VidicAdminEvent {
  String? endDate;
  CreateEndDateEvent({required this.endDate});
}

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
// create new statement
class CreateStatementEvent extends VidicAdminEvent {}

class UploadStatementFileEvent extends VidicAdminEvent {}

class CreateStatementStartDateEvent extends VidicAdminEvent {
  String? statementStartDate;
  CreateStatementStartDateEvent({required this.statementStartDate});
}

class CreateStatementEndDateEvent extends VidicAdminEvent {
  String? statementEndDate;
  CreateStatementEndDateEvent({required this.statementEndDate});
}

class CreateTenantStatementEvent extends VidicAdminEvent {
  String? tenantStatementName;
  CreateTenantStatementEvent({required this.tenantStatementName});
}

class UploadTenantStatementEvent extends VidicAdminEvent {
  String? amount;

  UploadTenantStatementEvent({required this.amount});
}

// ---------------------------------------------------------------
// create new invoice
class CreateInvoiceEvent extends VidicAdminEvent {}

class SetTenantInvoiceIdEvent extends VidicAdminEvent {
  String? tenantInvoiceId;
  SetTenantInvoiceIdEvent({required this.tenantInvoiceId});
}

class SetTenantInvoiceMonthEvent extends VidicAdminEvent {
  String? tenantInvoiceMonth;
  SetTenantInvoiceMonthEvent({required this.tenantInvoiceMonth});
}

class UploadInvoiceFileEvent extends VidicAdminEvent {}

class UploadTenantInvoiceEvent extends VidicAdminEvent {
  String? amount;
  String? purpose;

  UploadTenantInvoiceEvent({
    required this.amount,
    required this.purpose,
  });
}

// ---------------------------------------------------------------
// create new letter

class CreateLetterEvent extends VidicAdminEvent {}

class SetTenantLetterIdEvent extends VidicAdminEvent {
  String? tenantLetterId;
  SetTenantLetterIdEvent({required this.tenantLetterId});
}

class UploadLetterFileEvent extends VidicAdminEvent {}

class UploadTenantLetterEvent extends VidicAdminEvent {
  String? subject;

  UploadTenantLetterEvent({
    required this.subject,
  });
}

// ---------------------------------------------------------------
// create new occupancy

class UpdateOccupancyEvent extends VidicAdminEvent {
  int floorId;
  String occupancy;
  String capacity;

  UpdateOccupancyEvent({
    required this.floorId,
    required this.occupancy,
    required this.capacity,
  });
}

class UpdateOccupancyPatchEvent extends VidicAdminEvent {
  int floorId;
  String occupancy;
  String capacity;

  UpdateOccupancyPatchEvent({
    required this.floorId,
    required this.occupancy,
    required this.capacity,
  });
}

// ---------------------------------------------------------------
// update letters

class UpdateLettersPatchEvent extends VidicAdminEvent {
  int id;
  String subject;
  // String date;

  UpdateLettersPatchEvent({
    required this.id,
    required this.subject,
    // required this.date,
  });
}

class UploadLetterUpdateFileEvent extends VidicAdminEvent {}

class UpdateLettersPatchSendEvent extends VidicAdminEvent {
  String subject;
  // String date;

  UpdateLettersPatchSendEvent({
    required this.subject,
  });
}

// ---------------------------------------------------------------
// ---------------------------------------------------------------
// update invoices
// ---------------------------------------------------------------
class UpdateInvoicesEvent extends VidicAdminEvent {
  int id;
  String amount;
  String purpose;
  String invoiceMonth;
  // String date;

  UpdateInvoicesEvent({
    required this.id,
    required this.amount,
    required this.purpose,
    required this.invoiceMonth,
  });
}

class UpdateInvoiceMonthEvent extends VidicAdminEvent {
  String? tenantInvoiceMonth;
  String? purpose;
  String? amount;
  String uploadName;
  UpdateInvoiceMonthEvent({
    required this.tenantInvoiceMonth,
    required this.purpose,
    required this.amount,
    required this.uploadName,
  });
}

class UploadInvoiceUpdateFileEvent extends VidicAdminEvent {
  String? purpose;
  String? amount;
  UploadInvoiceUpdateFileEvent({
    required this.purpose,
    required this.amount,
  });
}

class UpdateInvoicePatchSendEvent extends VidicAdminEvent {
  String? purpose;
  String? amount;
  UpdateInvoicePatchSendEvent({
    required this.purpose,
    required this.amount,
  });
}

// ---------------------------------------------------------------
// ---------------------------------------------------------------
// update statement
// ---------------------------------------------------------------
class UpdateStatementsEvent extends VidicAdminEvent {
  final int id;
  final String amount;
  final DateTime statementStartDate;
  final DateTime statementEndDate;
  // String date;

  const UpdateStatementsEvent({
    required this.id,
    required this.amount,
    required this.statementStartDate,
    required this.statementEndDate,
  });
}

class UploadStatementUpdateFileEvent extends VidicAdminEvent {
  final String amount;
  const UploadStatementUpdateFileEvent({
    required this.amount,
  });
}

class CreateStatementUpdateStartDateEvent extends VidicAdminEvent {
  final DateTime statementStartDate;
  final String amount;
  const CreateStatementUpdateStartDateEvent({
    required this.statementStartDate,
    required this.amount,
  });
}

class CreateStatementUpdateEndDateEvent extends VidicAdminEvent {
  final DateTime statementEndDate;
  final String amount;
  const CreateStatementUpdateEndDateEvent({
    required this.statementEndDate,
    required this.amount,
  });
}

class UpdateStatementPatchSendEvent extends VidicAdminEvent {
  final String? amount;
  const UpdateStatementPatchSendEvent({
    required this.amount,
  });
}

// ---------------------------------------------------------------
// ---------------------------------------------------------------
// delete letters
// ---------------------------------------------------------------

class DeleteLetterRequestEvent extends VidicAdminEvent {
  final int? id;
  const DeleteLetterRequestEvent({
    required this.id,
  });
}

class DeleteLetterEvent extends VidicAdminEvent {}
