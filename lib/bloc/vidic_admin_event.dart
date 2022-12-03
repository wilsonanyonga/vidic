part of 'vidic_admin_bloc.dart';

abstract class VidicAdminEvent extends Equatable {
  const VidicAdminEvent();

  @override
  List<Object> get props => [];
}

class VidicInitialEvent extends VidicAdminEvent {}

class VidicLoginEvent extends VidicAdminEvent {
  final String email;
  final String password;
  const VidicLoginEvent({required this.email, required this.password});
}

// get User Name
class UserGetEvent extends VidicAdminEvent {}

// get details from database
class LogoutEvent extends VidicAdminEvent {}

class TenantGetEvent extends VidicAdminEvent {}

class TenantSearchEvent extends VidicAdminEvent {
  final String searchMe;
  const TenantSearchEvent({required this.searchMe});
}

class StatementGetEvent extends VidicAdminEvent {}

class StatementSearchEvent extends VidicAdminEvent {
  final String searchMe;
  const StatementSearchEvent({required this.searchMe});
}

class InvoiceGetEvent extends VidicAdminEvent {}

class InvoiceSearchEvent extends VidicAdminEvent {
  final String searchMe;
  const InvoiceSearchEvent({required this.searchMe});
}

class LetterGetEvent extends VidicAdminEvent {}

class LetterSearchEvent extends VidicAdminEvent {
  final String searchMe;
  const LetterSearchEvent({required this.searchMe});
}

class OccupancyGetEvent extends VidicAdminEvent {}

class ComplaintGetEvent extends VidicAdminEvent {}

class ComplaintSearchEvent extends VidicAdminEvent {
  final String searchMe;
  const ComplaintSearchEvent({required this.searchMe});
}
// ---------------------------------------------------------------

// create new tenant account

class CreateTenantEvent extends VidicAdminEvent {}

class CreateFloorEvent extends VidicAdminEvent {
  final String? floor;
  const CreateFloorEvent({required this.floor});
}

class CreateStartDateEvent extends VidicAdminEvent {
  final String? startDate;
  const CreateStartDateEvent({required this.startDate});
}

class CreateEndDateEvent extends VidicAdminEvent {
  final String? endDate;
  const CreateEndDateEvent({required this.endDate});
}

class CreateTenantDataEvent extends VidicAdminEvent {
  final String name;
  final String number;
  final String officialEmail;
  final String about;
  final String? floor;
  final String size;
  final String rent;
  final String escalation;
  final String pobox;
  final String leaseStartDate;
  final String leaseEndDate;
  final String active;
  const CreateTenantDataEvent(
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
  final String? statementStartDate;
  const CreateStatementStartDateEvent({required this.statementStartDate});
}

class CreateStatementEndDateEvent extends VidicAdminEvent {
  final String? statementEndDate;
  const CreateStatementEndDateEvent({required this.statementEndDate});
}

class CreateTenantStatementEvent extends VidicAdminEvent {
  final String? tenantStatementName;
  const CreateTenantStatementEvent({required this.tenantStatementName});
}

class UploadTenantStatementEvent extends VidicAdminEvent {
  final String? amount;

  const UploadTenantStatementEvent({required this.amount});
}

// ---------------------------------------------------------------
// create new invoice
class CreateInvoiceEvent extends VidicAdminEvent {}

class SetTenantInvoiceIdEvent extends VidicAdminEvent {
  final String? tenantInvoiceId;
  const SetTenantInvoiceIdEvent({required this.tenantInvoiceId});
}

class SetTenantInvoiceMonthEvent extends VidicAdminEvent {
  final String? tenantInvoiceMonth;
  const SetTenantInvoiceMonthEvent({required this.tenantInvoiceMonth});
}

class UploadInvoiceFileEvent extends VidicAdminEvent {}

class UploadTenantInvoiceEvent extends VidicAdminEvent {
  final String? amount;
  final String? purpose;

  const UploadTenantInvoiceEvent({
    required this.amount,
    required this.purpose,
  });
}

// ---------------------------------------------------------------
// create new letter

class CreateLetterEvent extends VidicAdminEvent {}

class SetTenantLetterIdEvent extends VidicAdminEvent {
  final String? tenantLetterId;
  const SetTenantLetterIdEvent({required this.tenantLetterId});
}

class UploadLetterFileEvent extends VidicAdminEvent {}

class UploadTenantLetterEvent extends VidicAdminEvent {
  final String? subject;

  const UploadTenantLetterEvent({
    required this.subject,
  });
}

// ---------------------------------------------------------------
// create new occupancy

class UpdateOccupancyEvent extends VidicAdminEvent {
  final int floorId;
  final String occupancy;
  final String capacity;

  const UpdateOccupancyEvent({
    required this.floorId,
    required this.occupancy,
    required this.capacity,
  });
}

class UpdateOccupancyPatchEvent extends VidicAdminEvent {
  final int floorId;
  final String occupancy;
  final String capacity;

  const UpdateOccupancyPatchEvent({
    required this.floorId,
    required this.occupancy,
    required this.capacity,
  });
}

// ---------------------------------------------------------------
// update letters

class UpdateLettersPatchEvent extends VidicAdminEvent {
  final int id;
  final String subject;
  // String date;

  const UpdateLettersPatchEvent({
    required this.id,
    required this.subject,
    // required this.date,
  });
}

class UploadLetterUpdateFileEvent extends VidicAdminEvent {}

class UpdateLettersPatchSendEvent extends VidicAdminEvent {
  final String subject;
  // String date;

  const UpdateLettersPatchSendEvent({
    required this.subject,
  });
}

// ---------------------------------------------------------------
// ---------------------------------------------------------------
// update invoices
// ---------------------------------------------------------------
class UpdateInvoicesEvent extends VidicAdminEvent {
  final int id;
  final String amount;
  final String purpose;
  final String invoiceMonth;
  // String date;

  const UpdateInvoicesEvent({
    required this.id,
    required this.amount,
    required this.purpose,
    required this.invoiceMonth,
  });
}

class UpdateInvoiceMonthEvent extends VidicAdminEvent {
  final String? tenantInvoiceMonth;
  final String? purpose;
  final String? amount;
  final String uploadName;
  const UpdateInvoiceMonthEvent({
    required this.tenantInvoiceMonth,
    required this.purpose,
    required this.amount,
    required this.uploadName,
  });
}

class UploadInvoiceUpdateFileEvent extends VidicAdminEvent {
  final String? purpose;
  final String? amount;
  const UploadInvoiceUpdateFileEvent({
    required this.purpose,
    required this.amount,
  });
}

class UpdateInvoicePatchSendEvent extends VidicAdminEvent {
  final String? purpose;
  final String? amount;
  const UpdateInvoicePatchSendEvent({
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
// update tenant
// ---------------------------------------------------------------

class UpdateTenantEvent extends VidicAdminEvent {
  // final int id;
  // final String amount;
  // final DateTime statementStartDate;
  // final DateTime statementEndDate;
  final int id;
  final String name;
  final String number;
  final String officialEmail;
  final String about;
  final String floor;
  final String size;
  final String rent;
  final String escalation;
  final String pobox;
  final DateTime leaseStartDate;
  final DateTime leaseEndDate;
  final String active;
  // String date;

  const UpdateTenantEvent({
    required this.id,
    required this.name,
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
    required this.active,
  });
}

class UpdateTenantFloorEvent extends VidicAdminEvent {
  final String? floor;
  final String name;
  final String number;
  final String officialEmail;
  final String about;
  final String size;
  final String rent;
  final String escalation;
  final String pobox;
  const UpdateTenantFloorEvent({
    required this.floor,
    required this.name,
    required this.number,
    required this.officialEmail,
    required this.about,
    required this.size,
    required this.rent,
    required this.escalation,
    required this.pobox,
  });
}

class UpdateTenantLeaseStartEvent extends VidicAdminEvent {
  final DateTime leaseStart;
  final String name;
  final String number;
  final String officialEmail;
  final String about;
  final String size;
  final String rent;
  final String escalation;
  final String pobox;
  const UpdateTenantLeaseStartEvent({
    required this.leaseStart,
    required this.name,
    required this.number,
    required this.officialEmail,
    required this.about,
    required this.size,
    required this.rent,
    required this.escalation,
    required this.pobox,
  });
}

class UpdateTenantLeaseEndEvent extends VidicAdminEvent {
  final DateTime? leaseEnd;
  final String name;
  final String number;
  final String officialEmail;
  final String about;
  final String size;
  final String rent;
  final String escalation;
  final String pobox;
  const UpdateTenantLeaseEndEvent({
    required this.leaseEnd,
    required this.name,
    required this.number,
    required this.officialEmail,
    required this.about,
    required this.size,
    required this.rent,
    required this.escalation,
    required this.pobox,
  });
}

class UpdateTenantDetailsEvent extends VidicAdminEvent {
  final String name;
  final String number;
  final String officialEmail;
  final String about;
  final String size;
  final String rent;
  final String escalation;
  final String pobox;
  const UpdateTenantDetailsEvent({
    required this.name,
    required this.number,
    required this.officialEmail,
    required this.about,
    required this.size,
    required this.rent,
    required this.escalation,
    required this.pobox,
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

// ---------------------------------------------------------------

// ---------------------------------------------------------------
// delete invoice
// ---------------------------------------------------------------

class DeleteInvoiceRequestEvent extends VidicAdminEvent {
  final int? id;
  const DeleteInvoiceRequestEvent({
    required this.id,
  });
}

class DeleteInvoiceEvent extends VidicAdminEvent {}

// ---------------------------------------------------------------

// ---------------------------------------------------------------
// delete statement
// ---------------------------------------------------------------

class DeleteStatementRequestEvent extends VidicAdminEvent {
  final int? id;
  const DeleteStatementRequestEvent({
    required this.id,
  });
}

class DeleteStatementEvent extends VidicAdminEvent {}

// ---------------------------------------------------------------

// ---------------------------------------------------------------
// delete tenant
// ---------------------------------------------------------------

class DeleteTenantRequestEvent extends VidicAdminEvent {
  final int? id;
  const DeleteTenantRequestEvent({
    required this.id,
  });
}

class DeleteTenantEvent extends VidicAdminEvent {}
