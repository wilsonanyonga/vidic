import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidic/models/invoice/get_invoice2.dart';
import 'package:vidic/models/landing/tenants2.dart';
import 'package:vidic/models/letter/get_letter2.dart';
import 'package:vidic/models/occupancy/get_occupancy2.dart';
// import 'package:vidic/models/statement/get_statement.dart';
import 'package:vidic/models/statement/get_statement_data.dart';
import 'package:vidic/models/tenant_letter/get_tenant_letter2.dart';
import 'package:vidic/utils/auth.dart';
import 'package:vidic/utils/dio_client.dart';

part 'vidic_admin_event.dart';
part 'vidic_admin_state.dart';

class VidicAdminBloc extends Bloc<VidicAdminEvent, VidicAdminState> {
  final DioClient _client = DioClient();
  Dio dio = Dio();
  String? floor;
  String? startDate;
  String? endDate;
  // List<DatumTenant>? tenantsList;
  // statents
  List<DatumTenant>? tenantsList;
  String? statementStartDate;
  String? statementEndDate;
  String? statementFileName;
  String? tenantStatementName;
  Uint8List? statementFile;

  String invoiceFileName = '';
  String? tenantInvoiceId;
  String? tenantInvoiceMonth;
  Uint8List? invoiceFile;

  String letterFileName = 'No File Selected';
  String? tenantLetterId;
  Uint8List? letterFile;

  // updating the letter
  String letterUpdateFileName = 'No File Selected';
  String letterUpdateSubject = '';
  int? letterUpdateId;
  Uint8List? letterUpdateFile;

  // updating the invoice
  int? invoiceUpdateId;
  Uint8List? invoiceUpdateFile;
  String? tenantInvoiceUpdateMonth;
  String invoiceUpdateFileName = '';
  String? tenantInvoiceUpdatePurpose;
  String? tenantInvoiceUpdateAmount;

  // Updating the statements
  int? statementUpdateId;
  String statementUpdateFileName = '';
  Uint8List? statementUpdateFile;
  DateTime? statementUpdateStartDate;
  DateTime? statementUpdateEndDate;
  String? statementUpdateAmount;

  // updating tenant
  int? idTenantUpdate;
  String? nameTenantUpdate;
  String? numberTenantUpdate;
  String? officialEmailTenantUpdate;
  String? aboutTenantUpdate;
  String? floorTenantUpdate;
  String? sizeTenantUpdate;
  String? rentTenantUpdate;
  String? escalationTenantUpdate;
  String? poboxTenantUpdate;
  DateTime? leaseStartDateTenantUpdate;
  DateTime? leaseEndDateTenantUpdate;
  String? activeTenantUpdate;

  // deleting letter
  int? letterDeleteId;

  // deleting invoice
  int? invoiceDeleteId;

  // deleting statement
  int? statementDeleteId;

  // deleting tenant
  int? tenantDeleteId;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      for (var i = 0; i < tenantsList!.length; i++)
        DropdownMenuItem(
            value: tenantsList![i].datumId.toString(),
            child: Text(tenantsList![i].name)),
    ];
    return menuItems;
  }

  VidicAdminBloc(DioClient of) : super(VidicAdminInitial()) {
    on<VidicAdminEvent>((event, emit) async {
      // ignore: todo
      // TODO: implement event handler
      // if (await Auth().authStateChanges.isEmpty) {
      //   emit(Login());
      // }
      if (await Auth().authStateChanges.isEmpty) {
        // emit(Login());
        if (kDebugMode) {
          print('object1');
        }
      }
      // emit(Login());
      if (kDebugMode) {
        print('object2');
      }
    });

    on<VidicInitialEvent>((event, emit) async {
      // ignore: todo
      // TODO: implement event handler
      emit(LoginState());
    });

    on<VidicLoginEvent>((event, emit) async {
      if (kDebugMode) {
        print('we are trying lod');
      }
      emit(LoginLoading());
      try {
        await Auth().signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        if (kDebugMode) {
          print('we are trying');
        }
        final myJwt = await _client.getToken(event.email);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', event.email);
        prefs.setString('jwt_token', myJwt!.data);
        prefs.setString('user_name', myJwt.user[0].name);

        if (kDebugMode) {
          print('email is ${event.email}');
          print('token is ${myJwt.data}');
        }

        // email: _controllerEmail.text,
      } on FirebaseAuthException catch (e) {
        if (kDebugMode) {
          print(e.message);
        }
        emit(LoginError(e.message));
        emit(LoginState());
      }
      emit(LoginState());
    });

    on<LogoutEvent>((event, emit) async {
      // ignore: todo
      // TODO: implement event handler
      // emit(LoginState());
    });

    // ------------------------------------------------------------------------------------------------------------
    // ----------- Tenants List --------------------------------
    // ------------------------------------------------------------------------------------------

    on<TenantGetEvent>((event, emit) async {
      // ignore: todo
      // TODO: implement event handler
      emit(TenantLoading());
      if (kDebugMode) {
        print("hehe start");
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //Return String
      String? stringValue = prefs.getString('jwt_token');
      if (stringValue == null) {
        await Future.delayed(const Duration(seconds: 2));

        final statements = await _client.getTenants();

        final occupancy = await _client.getOccupancy();
        // delay for token to be stored well in shared preferences

        // tenantsList = statements!.data;
        if (kDebugMode) {
          print("get home awaiting");
          print(statements!.data);
        }
        emit(TenantLoaded(statements!.data, occupancy!.data));
      }

      final statements = await _client.getTenants();

      final occupancy = await _client.getOccupancy();
      // delay for token to be stored well in shared preferences

      // tenantsList = statements!.data;
      if (kDebugMode) {
        print("get home direct");
        print(statements!.data);
      }
      emit(TenantLoaded(statements!.data, occupancy!.data));
    });

    // ----------- Tenants END--------------------------------

    // ----------- STATEMENT --------------------------------

    on<StatementGetEvent>((event, emit) async {
      // ignore: todo
      // TODO: implement event handler
      emit(StatementLoading());
      // await Future.delayed(const Duration(seconds: 2));
      final statements = await _client.getStatement();
      // tenantsList = statements!.data;
      if (kDebugMode) {
        print("hehe");
        print(statements!.data);
      }
      emit(StatementLoaded(statements!.data));
    });

    // ----------- STATEMENT END--------------------------------

    // ----------- INVOICE --------------------------------

    on<InvoiceGetEvent>((event, emit) async {
      // ignore: todo
      // TODO: implement event handler
      emit(InvoiceLoading());
      // await Future.delayed(const Duration(seconds: 2));
      final invoices = await _client.getInvoice();
      if (kDebugMode) {
        print("hehe");
        print(invoices!.data);
      }
      emit(InvoiceLoaded(invoices!.data));
    });

    // ------------------------------------------------------------------------------------------------------------
    // ----------- INVOICE END--------------------------------
    // ------------------------------------------------------------------------------------------

    // ------------------------------------------------------------------------------------------------------------
    // ----------- Letter --------------------------------
    // ------------------------------------------------------------------------------------------

    on<LetterGetEvent>((event, emit) async {
      // ignore: todo
      // TODO: implement event handler
      emit(LetterLoading());
      // await Future.delayed(const Duration(seconds: 2));
      final letters = await _client.getLetter();
      if (kDebugMode) {
        print("hehe");
        print(letters!.data);
      }
      emit(LetterLoaded(letters!.data));
    });

    // ------------------------------------------------------------------------------------------------------------
    // ----------- Letter END--------------------------------
    // ------------------------------------------------------------------------------------------

    // ------------------------------------------------------------------------------------------------------------
    // ----------- Letter Complaint --------------------------------
    // ------------------------------------------------------------------------------------------

    on<ComplaintGetEvent>((event, emit) async {
      // ignore: todo
      // TODO: implement event handler
      emit(ComplaintLoading());
      // await Future.delayed(const Duration(seconds: 2));
      final complaint = await _client.getTenantLetter();
      if (kDebugMode) {
        print("hehe");
        print(complaint!.data);
      }
      emit(ComplaintLoaded(complaint!.data));
    });

    // ----------- Letter Complaint END--------------------------------

    // ----------- Occupancy  --------------------------------

    on<OccupancyGetEvent>((event, emit) async {
      // ignore: todo
      // TODO: implement event handler
      emit(OccupancyLoading());
      // await Future.delayed(const Duration(seconds: 2));
      final occupancy = await _client.getOccupancy();
      if (kDebugMode) {
        print("hehe");
        print(occupancy!.data);
      }
      emit(OccupancyLoaded(occupancy!.data));
    });

    // ----------- Occupancy END--------------------------------

    // --------------------------------------------------------------------------

    // ----------- Create New Tenant ----------------------------
    on<CreateTenantEvent>((event, emit) {
      emit(const CreateTenantState(0));
    });

    on<CreateFloorEvent>((event, emit) {
      floor = event.floor;
      if (kDebugMode) {
        print("$floor is state");
      }
      emit(const CreateTenantState(0));
    });
    on<CreateStartDateEvent>((event, emit) {
      startDate = event.startDate;
      if (kDebugMode) {
        print("$startDate is state");
      }
      emit(const CreateTenantState(0));
    });
    on<CreateEndDateEvent>((event, emit) {
      endDate = event.endDate;
      if (kDebugMode) {
        print("$endDate is state");
      }
      emit(const CreateTenantState(0));
    });

    on<CreateTenantDataEvent>((event, emit) async {
      emit(const CreateTenantState(1));
      if (kDebugMode) {
        print(event.name);
        print(event.number);
        print(event.officialEmail);
        print(event.about);
        print(floor);
        print(event.size);
        print(event.rent);
        print(event.escalation);
        print(event.pobox);
        print(event.leaseStartDate);
        print(event.leaseEndDate);
        print(event.active);
      }
      // await Future.delayed(const Duration(seconds: 2));
      try {
        final newTenant = await _client.createTenant(
          name: event.name,
          number: event.number,
          officialEmail: event.officialEmail,
          about: event.about,
          floor: floor,
          size: event.size,
          rent: event.rent,
          escalation: event.escalation,
          pobox: event.pobox,
          leaseStartDate: startDate,
          leaseEndDate: endDate,
          active: event.active,
        );
        if (kDebugMode) {
          print("hehe");
          print(newTenant!.data);
          print(newTenant.status);
        }
        if (newTenant!.status == 200) {
          emit(const CreateTenantState(0));
          emit(TenantBackOption());
        }
      } catch (e) {
        if (kDebugMode) {
          print("hehe2");
          print(e);
        }
      }
    });
    // ----------- END Create New Tenant ----------------------------

    // ----------- Create New Statement ----------------------------
    on<CreateStatementEvent>((event, emit) async {
      if (kDebugMode) {
        print('create me');
        // print(dropdownItems);
      }
      try {
        final statements = await _client.getTenants();
        tenantsList = statements!.data;
        emit(CreateStatementState(0, '', dropdownItems));
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        emit(CreateStatementState(0, '', dropdownItems));
      }
    });

    on<UploadStatementFileEvent>((event, emit) async {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles();

        if (result != null) {
          statementFile = result.files.single.bytes!;
          if (kDebugMode) {
            print(result.files.single.name);
            print(statementFile!.length);
            print("upload worked");
          }
          statementFileName = result.files.single.name;
          emit(
              CreateStatementState(0, result.files.single.name, dropdownItems));
        } else {
          // User canceled the picker
          if (kDebugMode) {
            print("upload failed");
          }
          emit(CreateStatementState(0, '', dropdownItems));
        }
      } catch (e) {
        if (kDebugMode) {
          print("upload totally failed");
        }
        emit(CreateStatementState(0, '', dropdownItems));
      }

      // emit(CreateStatementState(0));
    });

    on<CreateStatementStartDateEvent>((event, emit) {
      statementStartDate = event.statementStartDate;
      if (kDebugMode) {
        print("$statementStartDate is state");
      }
      if (statementFileName == null) {
        // String statementFileName2 = '';
        emit(CreateStatementState(0, '', dropdownItems));
      } else {
        // String? statementFileName2 = statementFileName;
        emit(CreateStatementState(0, statementFileName, dropdownItems));
      }
    });
    on<CreateStatementEndDateEvent>((event, emit) {
      statementEndDate = event.statementEndDate;
      if (kDebugMode) {
        print("$statementEndDate is state");
      }
      if (statementFileName == null) {
        emit(CreateStatementState(0, '', dropdownItems));
      } else {
        emit(CreateStatementState(0, statementFileName, dropdownItems));
      }
    });

    on<CreateTenantStatementEvent>(
      (event, emit) {
        tenantStatementName = event.tenantStatementName;
        if (kDebugMode) {
          print("$tenantStatementName is state");
        }
        // emit(CreateTenantState(0));
        if (statementFileName == null) {
          emit(CreateStatementState(0, '', dropdownItems));
        } else {
          emit(CreateStatementState(0, statementFileName, dropdownItems));
        }
        // emit(CreateStatementState(0, statementFileName, dropdownItems));
      },
    );

    on<UploadTenantStatementEvent>(
      (event, emit) async {
        emit(CreateStatementState(1, statementFileName, dropdownItems));
        try {
          if (kDebugMode) {
            print(tenantStatementName);
            print(event.amount);
            print(statementStartDate);
            print(statementEndDate);
            print(statementFileName);
          }
          final newStatement = await _client.createStatement(
            tenantStatementName: tenantStatementName,
            amount: event.amount,
            statementStartDate: statementStartDate,
            statementEndDate: statementEndDate,
            statementFile: statementFile,
          );
          if (kDebugMode) {
            print("statement response");
            print(newStatement!.data);
            print(newStatement.status);
          }

          if (newStatement!.status == 2000) {
            // emit(CreateTenantState(0));
            emit(CreateStatementState(0, statementFileName, dropdownItems));
            emit(StatementBackOption());
          }
        } catch (e) {
          if (kDebugMode) {
            print('statement submit error');
            print('statement submit error is $e');
          }
          emit(CreateStatementState(0, statementFileName, dropdownItems));
        }
      },
    );

    // ----------- END Create New Statement ----------------------------

    // ----------- Create New Invoice ----------------------------
    on<CreateInvoiceEvent>(
      (event, emit) async {
        if (kDebugMode) {
          print('create invoice');
          // print(dropdownItems);
        }
        try {
          final invoice = await _client.getTenants();
          tenantsList = invoice!.data;
          emit(CreateInvoiceState(0, invoiceFileName, dropdownItems));
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          emit(CreateInvoiceState(0, invoiceFileName, dropdownItems));
        }
      },
    );
    on<SetTenantInvoiceIdEvent>(
      (event, emit) {
        tenantInvoiceId = event.tenantInvoiceId;
        if (kDebugMode) {
          print("$tenantInvoiceId is state");
        }
        emit(CreateInvoiceState(0, invoiceFileName, dropdownItems));
      },
    );
    on<SetTenantInvoiceMonthEvent>(
      (event, emit) {
        tenantInvoiceMonth = event.tenantInvoiceMonth;
        if (kDebugMode) {
          print("$tenantInvoiceMonth is state");
        }
        emit(CreateInvoiceState(0, invoiceFileName, dropdownItems));
      },
    );

    // UploadInvoiceFileEvent
    on<UploadInvoiceFileEvent>(
      (event, emit) async {
        try {
          FilePickerResult? result = await FilePicker.platform.pickFiles();

          if (result != null) {
            invoiceFile = result.files.single.bytes!;
            if (kDebugMode) {
              print(result.files.single.name);
              print(invoiceFile!.length);
              print("upload worked");
            }
            invoiceFileName = result.files.single.name;
            emit(
                CreateInvoiceState(0, result.files.single.name, dropdownItems));
          } else {
            // User canceled the picker
            if (kDebugMode) {
              print("upload failed");
            }
            emit(CreateInvoiceState(0, invoiceFileName, dropdownItems));
          }
        } catch (e) {
          if (kDebugMode) {
            print("upload totally failed");
          }
          emit(CreateInvoiceState(0, invoiceFileName, dropdownItems));
        }

        // emit(CreateStatementState(0));
      },
    );
    // this is the upload button event
    on<UploadTenantInvoiceEvent>(
      (event, emit) async {
        emit(CreateInvoiceState(1, invoiceFileName, dropdownItems));
        try {
          if (kDebugMode) {
            print(tenantInvoiceId);
            print(event.amount);
            print(event.purpose);
            print(tenantInvoiceMonth);
            // print(invoiceFile);
          }
          final newInvoice = await _client.createInvoice(
            tenantInvoiceId: tenantInvoiceId,
            amount: event.amount,
            purpose: event.purpose,
            invoiceMonth: tenantInvoiceMonth,
            invoiceFile: invoiceFile,
          );
          if (kDebugMode) {
            print("invoice response");
            print(newInvoice!.data);
            print(newInvoice.status);
          }

          if (newInvoice!.status == 2000) {
            // emit(CreateTenantState(0));
            emit(CreateInvoiceState(0, invoiceFileName, dropdownItems));
            emit(InvoiceBackOption());
          }
        } catch (e) {
          if (kDebugMode) {
            print('invoice submit error');
            print('invoice submit error is $e');
          }
          emit(CreateInvoiceState(0, invoiceFileName, dropdownItems));
        }
      },
    );

    // ----------- END Create New Invoice ----------------------------

    // ----------- Create New Letter ----------------------------
    on<CreateLetterEvent>(
      (event, emit) async {
        if (kDebugMode) {
          print('create letter');
          // print(dropdownItems);
        }
        try {
          final tenants = await _client.getTenants();
          tenantsList = tenants!.data;
          emit(CreateLetterState(0, letterFileName, dropdownItems));
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          emit(CreateLetterState(0, letterFileName, dropdownItems));
        }
      },
    );

    on<SetTenantLetterIdEvent>(
      (event, emit) {
        tenantLetterId = event.tenantLetterId;
        if (kDebugMode) {
          print("$tenantInvoiceId is state");
          DateTime now = DateTime.now();
          DateTime date = DateTime(now.year, now.month, now.day);
          print(date.toString().replaceAll(' 00:00:00.000', ''));
        }
        emit(CreateLetterState(0, letterFileName, dropdownItems));
      },
    );

    // UploadLetterFileEvent
    on<UploadLetterFileEvent>(
      (event, emit) async {
        try {
          FilePickerResult? result = await FilePicker.platform.pickFiles();

          if (result != null) {
            letterFile = result.files.single.bytes!;
            if (kDebugMode) {
              print(result.files.single.name);
              print(letterFile!.length);
              print("upload worked");
            }
            letterFileName = result.files.single.name;
            emit(CreateLetterState(0, letterFileName, dropdownItems));
          } else {
            // User canceled the picker
            if (kDebugMode) {
              print("upload failed");
            }
            emit(CreateLetterState(0, letterFileName, dropdownItems));
          }
        } catch (e) {
          if (kDebugMode) {
            print("upload totally failed $e");
          }
          emit(CreateLetterState(0, letterFileName, dropdownItems));
        }

        // emit(CreateStatementState(0));
      },
    );

    // this is the upload button event
    on<UploadTenantLetterEvent>(
      (event, emit) async {
        emit(CreateLetterState(1, letterFileName, dropdownItems));
        try {
          DateTime now = DateTime.now();
          DateTime date = DateTime(now.year, now.month, now.day);
          if (kDebugMode) {
            print(tenantLetterId);
            print(event.subject);
            // print(event.purpose);
            // print(tenantInvoiceMonth);
            // print(invoiceFile);
          }
          final newLetter = await _client.createLetter(
            tenantLetterId: tenantLetterId,
            subject: event.subject,
            date: date.toString().replaceAll(' 00:00:00.000', ''),
            letterFile: letterFile,
          );
          if (kDebugMode) {
            print("invoice response");
            print(newLetter!.data);
            print(newLetter.status);
          }

          if (newLetter!.status == 2000) {
            // emit(CreateTenantState(0));
            emit(CreateLetterState(0, letterFileName, dropdownItems));
            emit(LetterBackOption());
          }
        } catch (e) {
          if (kDebugMode) {
            print('invoice submit error');
            print('invoice submit error is $e');
          }
          emit(CreateLetterState(0, letterFileName, dropdownItems));
        }
      },
    );

    // ----------- END Create New Letter ----------------------------

    // ----------- Create New Occupancy ----------------------------
    on<UpdateOccupancyEvent>(
      (event, emit) async {
        if (kDebugMode) {
          print('create letter');
          // print(dropdownItems);
        }
        //     this.floorId,
        // this.occupancy,
        // this.capacity,
        // this.loadingButton,
        emit(
          UpdateOccupancyState(
            event.floorId,
            event.occupancy,
            event.capacity,
            0,
          ),
        );
        // try {
        //   final tenants = await _client.getTenants();
        //   tenantsList = tenants!.data;
        //   emit(CreateLetterState(0, letterFileName, dropdownItems));
        // } catch (e) {
        //   if (kDebugMode) {
        //     print(e);
        //   }
        //   emit(CreateLetterState(0, letterFileName, dropdownItems));
        // }
      },
    );

    on<UpdateOccupancyPatchEvent>(
      (event, emit) async {
        if (kDebugMode) {
          print('update occupancy');
          // print(dropdownItems);
        }

        emit(
          UpdateOccupancyState(
            event.floorId,
            event.occupancy,
            event.capacity,
            1,
          ),
        );
        try {
          if (kDebugMode) {
            print(event.floorId);
            print(event.occupancy);
            print(event.capacity);
            // print(tenantInvoiceMonth);
            // print(invoiceFile);
          }
          final updatedOccupancy = await _client.updateOccupancy(
            occupancy: event.occupancy,
            capacity: event.capacity,
            floorId: event.floorId,
          );
          if (kDebugMode) {
            print("invoice response");
            print(updatedOccupancy!.data);
            print(updatedOccupancy.status);
          }

          if (updatedOccupancy!.status == 2000) {
            // emit(CreateTenantState(0));
            emit(
              UpdateOccupancyState(
                event.floorId,
                event.occupancy,
                event.capacity,
                0,
              ),
            );
            // emit(CreateLetterState(0, letterFileName, dropdownItems));
            emit(OccupancyBackOption());
          }
        } catch (e) {
          if (kDebugMode) {
            print('invoice submit error');
            print('invoice submit error is $e');
          }
          emit(
            UpdateOccupancyState(
              event.floorId,
              event.occupancy,
              event.capacity,
              0,
            ),
          );
        }
      },

      // },
    );

    // ----------- END Update Occupancy ----------------------------

    // ----------- Update Letters ----------------------------
    on<UpdateLettersPatchEvent>(
      (event, emit) async {
        if (kDebugMode) {
          print('update letter');
          // print(dropdownItems);
        }
        //     this.floorId,
        // this.occupancy,
        // this.capacity,
        // this.loadingButton,
        letterUpdateSubject = event.subject;
        letterUpdateId = event.id;
        emit(
          UpdateLettersPatchState(
            event.id,
            event.subject,
            // event.date,
            0,
            letterUpdateFileName,
          ),
        );
        // try {
        //   final tenants = await _client.getTenants();
        //   tenantsList = tenants!.data;
        //   emit(CreateLetterState(0, letterFileName, dropdownItems));
        // } catch (e) {
        //   if (kDebugMode) {
        //     print(e);
        //   }
        //   emit(CreateLetterState(0, letterFileName, dropdownItems));
        // }
      },
    );

    // UploadLetterFileEvent
    on<UploadLetterUpdateFileEvent>(
      (event, emit) async {
        try {
          FilePickerResult? result = await FilePicker.platform.pickFiles();

          if (result != null) {
            letterUpdateFile = result.files.single.bytes!;
            if (kDebugMode) {
              print(result.files.single.name);
              print(letterUpdateFile!.length);
              print("upload worked");
            }
            letterUpdateFileName = result.files.single.name;
            emit(
              UpdateLettersPatchState(
                letterUpdateId,
                letterUpdateSubject,
                // event.date,
                0,
                letterUpdateFileName,
              ),
            );
            // emit(CreateLetterState(0, letterFileName, dropdownItems));
          } else {
            // User canceled the picker
            if (kDebugMode) {
              print("upload failed");
            }
            emit(
              UpdateLettersPatchState(
                letterUpdateId,
                letterUpdateSubject,
                // event.date,
                0,
                letterUpdateFileName,
              ),
            );
            // emit(CreateLetterState(0, letterFileName, dropdownItems));
          }
        } catch (e) {
          if (kDebugMode) {
            print("upload totally failed $e");
          }
          emit(
            UpdateLettersPatchState(
              letterUpdateId,
              letterUpdateSubject,
              // event.date,
              0,
              letterUpdateFileName,
            ),
          );
          // emit(CreateLetterState(0, letterFileName, dropdownItems));
        }

        // emit(CreateStatementState(0));
      },
    );

    // this is the update upload button event
    on<UpdateLettersPatchSendEvent>(
      (event, emit) async {
        // emit(CreateLetterState(1, letterFileName, dropdownItems));
        emit(
          UpdateLettersPatchState(
            letterUpdateId,
            event.subject,
            // event.date,
            1,
            letterUpdateFileName,
          ),
        );
        try {
          DateTime now = DateTime.now();
          DateTime date = DateTime(now.year, now.month, now.day);
          if (kDebugMode) {
            print(letterUpdateId);
            // print(event.subject);
            // print(event.purpose);
            // print(tenantInvoiceMonth);
            // print(invoiceFile);
          }
          final updateLetter = await _client.updateLetter(
            id: letterUpdateId,
            subject: event.subject,
            date: date.toString().replaceAll(' 00:00:00.000', ''),
            letterFile: letterUpdateFile,
          );
          if (kDebugMode) {
            print("invoice response");
            print(updateLetter!.data);
            print(updateLetter.status);
          }

          if (updateLetter!.status == 2000) {
            // emit(CreateTenantState(0));
            emit(
              UpdateLettersPatchState(
                letterUpdateId,
                letterUpdateSubject,
                // event.date,
                0,
                letterUpdateFileName,
              ),
            );
            letterUpdateFileName = '';
            letterFile = null;
            // emit(CreateLetterState(0, letterFileName, dropdownItems));
            emit(UpdateLetterBackOption());
          }
        } catch (e) {
          if (kDebugMode) {
            print('invoice submit error');
            print('invoice submit error is $e');
          }
          emit(
            UpdateLettersPatchState(
              letterUpdateId,
              letterUpdateSubject,
              // event.date,
              0,
              letterUpdateFileName,
            ),
          );
          // emit(CreateLetterState(0, letterFileName, dropdownItems));
        }
      },
    );

    // ----------- END Update Letter ----------------------------

    // ----------- Update Invoice ----------------------------
    on<UpdateInvoicesEvent>(
      (event, emit) async {
        if (kDebugMode) {
          print('update invoice');
        }

        tenantInvoiceUpdateMonth = event.invoiceMonth;
        invoiceUpdateId = event.id;
        tenantInvoiceUpdatePurpose = event.purpose;
        tenantInvoiceUpdateAmount = event.amount;

        emit(
          UpdateInvoicesState(
            invoiceUpdateId,
            tenantInvoiceUpdateAmount,
            tenantInvoiceUpdatePurpose,
            tenantInvoiceUpdateMonth,
            letterUpdateFileName,
            0,
          ),
        );
      },
    );

    on<UpdateInvoiceMonthEvent>(
      (event, emit) {
        tenantInvoiceUpdateMonth = event.tenantInvoiceMonth;
        tenantInvoiceUpdateAmount = event.amount;
        tenantInvoiceUpdatePurpose = event.purpose;
        letterUpdateFileName = event.uploadName;

        if (kDebugMode) {
          print("$tenantInvoiceUpdateMonth is state");
        }
        emit(
          UpdateInvoicesState(
            invoiceUpdateId,
            tenantInvoiceUpdateAmount,
            tenantInvoiceUpdatePurpose,
            tenantInvoiceUpdateMonth,
            letterUpdateFileName,
            0,
          ),
        );
        // emit(CreateInvoiceState(0, invoiceFileName, dropdownItems));
      },
    );

    // UploadInvoiceFileEvent
    on<UploadInvoiceUpdateFileEvent>(
      (event, emit) async {
        try {
          tenantInvoiceUpdateAmount = event.amount;
          tenantInvoiceUpdatePurpose = event.purpose;
          FilePickerResult? result = await FilePicker.platform.pickFiles();

          if (result != null) {
            invoiceUpdateFile = result.files.single.bytes!;
            if (kDebugMode) {
              print(result.files.single.name);
              print(invoiceUpdateFile!.length);
              print("upload worked");
            }
            invoiceUpdateFileName = result.files.single.name;
            emit(
              UpdateInvoicesState(
                invoiceUpdateId,
                tenantInvoiceUpdateAmount,
                tenantInvoiceUpdatePurpose,
                tenantInvoiceUpdateMonth,
                invoiceUpdateFileName,
                0,
              ),
            );
            // emit(
            //     CreateInvoiceState(0, result.files.single.name, dropdownItems));
          } else {
            // User canceled the picker
            if (kDebugMode) {
              print("upload failed");
            }
            emit(
              UpdateInvoicesState(
                invoiceUpdateId,
                tenantInvoiceUpdateAmount,
                tenantInvoiceUpdatePurpose,
                tenantInvoiceUpdateMonth,
                letterUpdateFileName,
                0,
              ),
            );
            // emit(CreateInvoiceState(0, invoiceFileName, dropdownItems));
          }
        } catch (e) {
          if (kDebugMode) {
            print("upload totally failed");
          }
          emit(
            UpdateInvoicesState(
              invoiceUpdateId,
              tenantInvoiceUpdateAmount,
              tenantInvoiceUpdatePurpose,
              tenantInvoiceUpdateMonth,
              letterUpdateFileName,
              0,
            ),
          );
          // emit(CreateInvoiceState(0, invoiceFileName, dropdownItems));
        }

        // emit(CreateStatementState(0));
      },
    );

    // this is the update upload button event
    on<UpdateInvoicePatchSendEvent>(
      (event, emit) async {
        tenantInvoiceUpdateAmount = event.amount;
        tenantInvoiceUpdatePurpose = event.purpose;
        emit(
          UpdateInvoicesState(
            invoiceUpdateId,
            tenantInvoiceUpdateAmount,
            tenantInvoiceUpdatePurpose,
            tenantInvoiceUpdateMonth,
            letterUpdateFileName,
            1,
          ),
        );
        try {
          if (kDebugMode) {
            print(letterUpdateId);
          }
          final updateInvoice = await _client.updateInvoice(
            id: invoiceUpdateId,
            amount: tenantInvoiceUpdateAmount,
            purpose: tenantInvoiceUpdatePurpose,
            invoiceMonth: tenantInvoiceUpdateMonth,
            invoiceFile: invoiceUpdateFile,
          );
          if (kDebugMode) {
            print("invoice response");
            print(updateInvoice!.data);
            print(updateInvoice.status);
          }

          if (updateInvoice!.status == 2000) {
            emit(
              UpdateInvoicesState(
                invoiceUpdateId,
                tenantInvoiceUpdateAmount,
                tenantInvoiceUpdatePurpose,
                tenantInvoiceUpdateMonth,
                letterUpdateFileName,
                0,
              ),
            );
            letterUpdateFileName = '';
            invoiceUpdateFile = null;
            // emit(CreateLetterState(0, letterFileName, dropdownItems));
            emit(UpdateInvoiceBackOption());
          }
        } catch (e) {
          if (kDebugMode) {
            print('invoice submit error');
            print('invoice submit error is $e');
          }
          emit(
            UpdateInvoicesState(
              invoiceUpdateId,
              tenantInvoiceUpdateAmount,
              tenantInvoiceUpdatePurpose,
              tenantInvoiceUpdateMonth,
              letterUpdateFileName,
              0,
            ),
          );
        }
      },
    );

    // ----------- END Update Invoice ----------------------------

    // ----------------------------------------------------------
    // ----------- Update Statements ----------------------------
    // ----------------------------------------------------------

    on<UpdateStatementsEvent>(
      (event, emit) async {
        if (kDebugMode) {
          print('update invoice');
        }
        statementUpdateId = event.id;
        // Uint8List? statementUpdateFile;
        statementUpdateStartDate = event.statementStartDate.toLocal();
        statementUpdateEndDate = event.statementEndDate.toLocal();
        statementUpdateAmount = event.amount;
        if (kDebugMode) {
          print('details are');
          print(statementUpdateId);
          print(statementUpdateStartDate);
          print(statementUpdateEndDate);
          print(statementUpdateAmount);
        }
        emit(
          UpdateStatementsState(
            // invoiceUpdateId,
            statementUpdateAmount,
            statementUpdateStartDate,
            statementUpdateEndDate,
            statementUpdateFileName,
            0,
          ),
        );
      },
    );
    //

    // CreateStatementUpdateStartDateEvent
    on<CreateStatementUpdateStartDateEvent>(
      (event, emit) async {
        if (kDebugMode) {
          print('update invoice');
        }
        // statementUpdateId = event.id;
        // Uint8List? statementUpdateFile;
        statementUpdateStartDate = event.statementStartDate;
        statementUpdateAmount = event.amount;
        // statementUpdateEndDate = event.statementEndDate;
        // statementUpdateAmount = event.amount;
        if (kDebugMode) {
          print('details are');
          print(statementUpdateId);
          print(statementUpdateStartDate);
          print(statementUpdateEndDate);
          print(statementUpdateAmount);
        }
        emit(
          UpdateStatementsState(
            // invoiceUpdateId,
            statementUpdateAmount,
            statementUpdateStartDate,
            statementUpdateEndDate,
            statementUpdateFileName,
            0,
          ),
        );
      },
    );

    // CreateStatementUpdateEndDateEvent
    on<CreateStatementUpdateEndDateEvent>(
      (event, emit) async {
        if (kDebugMode) {
          print('update invoice');
        }
        // statementUpdateId = event.id;
        // Uint8List? statementUpdateFile;
        statementUpdateEndDate = event.statementEndDate;
        statementUpdateAmount = event.amount;
        // statementUpdateEndDate = event.statementEndDate;
        // statementUpdateAmount = event.amount;
        if (kDebugMode) {
          print('details are');
          print(statementUpdateId);
          print(statementUpdateStartDate);
          print(statementUpdateEndDate);
          print(statementUpdateAmount);
        }
        emit(
          UpdateStatementsState(
            // invoiceUpdateId,
            statementUpdateAmount,
            statementUpdateStartDate,
            statementUpdateEndDate,
            statementUpdateFileName,
            0,
          ),
        );
      },
    );

    //  UploadInvoiceFileEvent
    on<UploadStatementUpdateFileEvent>(
      (event, emit) async {
        try {
          statementUpdateAmount = event.amount;
          // tenantInvoiceUpdatePurpose = event.purpose;
          FilePickerResult? result = await FilePicker.platform.pickFiles();

          if (result != null) {
            statementUpdateFile = result.files.single.bytes!;
            if (kDebugMode) {
              print(result.files.single.name);
              print(statementUpdateFile!.length);
              print("upload worked");
            }
            statementUpdateFileName = result.files.single.name;
            emit(
              UpdateStatementsState(
                // invoiceUpdateId,
                statementUpdateAmount,
                statementUpdateStartDate,
                statementUpdateEndDate,
                statementUpdateFileName,
                0,
              ),
            );
            // emit(
            //     CreateInvoiceState(0, result.files.single.name, dropdownItems));
          } else {
            // User canceled the picker
            if (kDebugMode) {
              print("upload failed");
            }
            emit(
              UpdateStatementsState(
                // invoiceUpdateId,
                statementUpdateAmount,
                statementUpdateStartDate,
                statementUpdateEndDate,
                statementUpdateFileName,
                0,
              ),
            );
            // emit(CreateInvoiceState(0, invoiceFileName, dropdownItems));
          }
        } catch (e) {
          if (kDebugMode) {
            print("upload totally failed");
          }
          emit(
            UpdateStatementsState(
              // invoiceUpdateId,
              statementUpdateAmount,
              statementUpdateStartDate,
              statementUpdateEndDate,
              statementUpdateFileName,
              0,
            ),
          );
          // emit(CreateInvoiceState(0, invoiceFileName, dropdownItems));
        }

        // emit(CreateStatementState(0));
      },
    );

    // this is the update upload button event
    on<UpdateStatementPatchSendEvent>(
      (event, emit) async {
        statementUpdateAmount = event.amount;
        if (kDebugMode) {
          // print('sending, ${event.amount}');
          // print('sending 2, ${tenantInvoiceUpdateAmount!}');
        }
        emit(
          UpdateStatementsState(
            statementUpdateAmount,
            statementUpdateStartDate,
            statementUpdateEndDate,
            statementUpdateFileName,
            1,
          ),
        );
        try {
          if (kDebugMode) {
            // print(letterUpdateId);
          }
          final updateStatement = await _client.updateStatement(
            id: statementUpdateId,
            amount: statementUpdateAmount,
            statementStartDate: statementUpdateStartDate
                .toString()
                .replaceAll(' 00:00:00.000', ''),
            statementEndDate: statementUpdateEndDate
                .toString()
                .replaceAll(' 00:00:00.000', ''),
            statementFile: statementUpdateFile,
          );
          if (kDebugMode) {
            print("invoice response");
            print(updateStatement!.data);
            print(updateStatement.status);
          }

          if (updateStatement!.status == 2000) {
            emit(
              UpdateStatementsState(
                statementUpdateAmount,
                statementUpdateStartDate,
                statementUpdateEndDate,
                statementUpdateFileName,
                0,
              ),
            );
            statementUpdateFileName = '';
            statementUpdateFile = null;
            statementUpdateAmount = '';
            // emit(CreateLetterState(0, letterFileName, dropdownItems));
            emit(UpdateStatementBackOption());
          }
        } catch (e) {
          if (kDebugMode) {
            print('invoice submit error');
            print('invoice submit error is $e');
          }
          emit(
            UpdateStatementsState(
              statementUpdateAmount,
              statementUpdateStartDate,
              statementUpdateEndDate,
              statementUpdateFileName,
              0,
            ),
          );
        }
      },
    );

    // ----------------------------------------------------------
    // ----------- Update Tenants ------------------------------
    // ----------------------------------------------------------
    // UpdateTenantEvent

    on<UpdateTenantEvent>(
      (event, emit) async {
        if (kDebugMode) {
          print('update invoice');
        }
        // statementUpdateId = event.id;
        // // Uint8List? statementUpdateFile;
        // statementUpdateStartDate = event.statementStartDate;
        // statementUpdateEndDate = event.statementEndDate;
        // statementUpdateAmount = event.amount;

        // String start = event.leaseStartDate
        //     .toString()
        //     .replaceAll('21:00:00.000', '12:00:00.000');
        // 00:00:00+03:00
        // .toString().replaceAll(' 00:00:00.000', '')
        if (kDebugMode) {
          print(event.leaseStartDate.toLocal());

          // print(start);
        }
        idTenantUpdate = event.id;
        nameTenantUpdate = event.name;
        numberTenantUpdate = event.number;
        officialEmailTenantUpdate = event.officialEmail;
        aboutTenantUpdate = event.about;
        floorTenantUpdate = event.floor;
        sizeTenantUpdate = event.size;
        rentTenantUpdate = event.rent;
        escalationTenantUpdate = event.escalation;
        poboxTenantUpdate = event.pobox;
        leaseStartDateTenantUpdate = event.leaseStartDate.toLocal();
        // leaseStartDateTenantUpdate = DateTime.parse(start);

        leaseEndDateTenantUpdate = event.leaseEndDate.toLocal();
        activeTenantUpdate = event.active;
        if (kDebugMode) {
          print('details are');
          print(idTenantUpdate);
          print(nameTenantUpdate);
          print(numberTenantUpdate);
          print(officialEmailTenantUpdate);
        }
        emit(
          UpdateTenantState(
            nameTenantUpdate,
            numberTenantUpdate,
            officialEmailTenantUpdate,
            aboutTenantUpdate,
            floorTenantUpdate,
            sizeTenantUpdate,
            rentTenantUpdate,
            escalationTenantUpdate,
            poboxTenantUpdate,
            leaseStartDateTenantUpdate,
            leaseEndDateTenantUpdate,
            activeTenantUpdate,
            0,
          ),
        );
      },
    );

    // UpdateTenantFloorEvent
    on<UpdateTenantFloorEvent>(
      (event, emit) async {
        if (kDebugMode) {
          print('update floor');
        }

        floorTenantUpdate = event.floor;

        nameTenantUpdate = event.name;
        numberTenantUpdate = event.number;
        officialEmailTenantUpdate = event.officialEmail;
        aboutTenantUpdate = event.about;
        // floorTenantUpdate = event.floor;
        sizeTenantUpdate = event.size;
        rentTenantUpdate = event.rent;
        escalationTenantUpdate = event.escalation;
        poboxTenantUpdate = event.pobox;

        if (kDebugMode) {
          print('details are');
          print(floorTenantUpdate);
          print(nameTenantUpdate);
          print(numberTenantUpdate);
          print(officialEmailTenantUpdate);
        }
        emit(
          UpdateTenantState(
            nameTenantUpdate,
            numberTenantUpdate,
            officialEmailTenantUpdate,
            aboutTenantUpdate,
            floorTenantUpdate,
            sizeTenantUpdate,
            rentTenantUpdate,
            escalationTenantUpdate,
            poboxTenantUpdate,
            leaseStartDateTenantUpdate,
            leaseEndDateTenantUpdate,
            activeTenantUpdate,
            0,
          ),
        );
      },
    );

    // UpdateTenantLeaseStartEvent
    on<UpdateTenantLeaseStartEvent>(
      (event, emit) async {
        if (kDebugMode) {
          print('update lease staer');
        }
        // .toString().replaceAll(' 00:00:00.000', '')
        leaseStartDateTenantUpdate = event.leaseStart;

        nameTenantUpdate = event.name;
        numberTenantUpdate = event.number;
        officialEmailTenantUpdate = event.officialEmail;
        aboutTenantUpdate = event.about;
        sizeTenantUpdate = event.size;
        rentTenantUpdate = event.rent;
        escalationTenantUpdate = event.escalation;
        poboxTenantUpdate = event.pobox;

        if (kDebugMode) {
          print('details are');
          print(floorTenantUpdate);
          print(leaseStartDateTenantUpdate);
          print(numberTenantUpdate);
          print(officialEmailTenantUpdate);
        }
        emit(
          UpdateTenantState(
            nameTenantUpdate,
            numberTenantUpdate,
            officialEmailTenantUpdate,
            aboutTenantUpdate,
            floorTenantUpdate,
            sizeTenantUpdate,
            rentTenantUpdate,
            escalationTenantUpdate,
            poboxTenantUpdate,
            leaseStartDateTenantUpdate,
            leaseEndDateTenantUpdate,
            activeTenantUpdate,
            0,
          ),
        );
      },
    );

    on<UpdateTenantLeaseEndEvent>(
      (event, emit) async {
        if (kDebugMode) {
          print('update lease end');
        }

        leaseEndDateTenantUpdate = event.leaseEnd;

        nameTenantUpdate = event.name;
        numberTenantUpdate = event.number;
        officialEmailTenantUpdate = event.officialEmail;
        aboutTenantUpdate = event.about;
        sizeTenantUpdate = event.size;
        rentTenantUpdate = event.rent;
        escalationTenantUpdate = event.escalation;
        poboxTenantUpdate = event.pobox;

        if (kDebugMode) {
          print('details are');
          print(floorTenantUpdate);
          print(leaseEndDateTenantUpdate);
          print(numberTenantUpdate);
          print(officialEmailTenantUpdate);
        }
        emit(
          UpdateTenantState(
            nameTenantUpdate,
            numberTenantUpdate,
            officialEmailTenantUpdate,
            aboutTenantUpdate,
            floorTenantUpdate,
            sizeTenantUpdate,
            rentTenantUpdate,
            escalationTenantUpdate,
            poboxTenantUpdate,
            leaseStartDateTenantUpdate,
            leaseEndDateTenantUpdate,
            activeTenantUpdate,
            0,
          ),
        );
      },
    );

    // UpdateTenantDetailsEvent
    // this is the update upload button event
    on<UpdateTenantDetailsEvent>(
      (event, emit) async {
        // statementUpdateAmount = event.amount;
        nameTenantUpdate = event.name;
        numberTenantUpdate = event.number;
        officialEmailTenantUpdate = event.officialEmail;
        aboutTenantUpdate = event.about;
        sizeTenantUpdate = event.size;
        rentTenantUpdate = event.rent;
        escalationTenantUpdate = event.escalation;
        poboxTenantUpdate = event.pobox;
        if (kDebugMode) {
          // print('sending, ${event.amount}');
          print(
              'sending 2, ${leaseStartDateTenantUpdate.toString().substring(0, 10)}');
        }
        emit(
          UpdateTenantState(
            nameTenantUpdate,
            numberTenantUpdate,
            officialEmailTenantUpdate,
            aboutTenantUpdate,
            floorTenantUpdate,
            sizeTenantUpdate,
            rentTenantUpdate,
            escalationTenantUpdate,
            poboxTenantUpdate,
            leaseStartDateTenantUpdate,
            leaseEndDateTenantUpdate,
            activeTenantUpdate,
            1,
          ),
        );
        try {
          if (kDebugMode) {
            // print(letterUpdateId);
          }
          final updateStatement = await _client.updateTenant(
            id: idTenantUpdate,
            name: nameTenantUpdate!,
            number: numberTenantUpdate!,
            leaseStartDate:
                leaseStartDateTenantUpdate.toString().substring(0, 10),
            leaseEndDate: leaseEndDateTenantUpdate.toString().substring(0, 10),
            about: aboutTenantUpdate!,
            active: '1',
            escalation: escalationTenantUpdate!,
            officialEmail: officialEmailTenantUpdate!,
            pobox: poboxTenantUpdate!,
            rent: rentTenantUpdate!,
            size: sizeTenantUpdate!,
          );
          if (kDebugMode) {
            print("invoice response");
            print(updateStatement!.data);
            print(updateStatement.status);
          }

          if (updateStatement!.status == 2000) {
            emit(
              UpdateTenantState(
                nameTenantUpdate,
                numberTenantUpdate,
                officialEmailTenantUpdate,
                aboutTenantUpdate,
                floorTenantUpdate,
                sizeTenantUpdate,
                rentTenantUpdate,
                escalationTenantUpdate,
                poboxTenantUpdate,
                leaseStartDateTenantUpdate,
                leaseEndDateTenantUpdate,
                activeTenantUpdate,
                0,
              ),
            );
            // statementUpdateFileName = '';
            // statementUpdateFile = null;
            // statementUpdateAmount = '';
            // emit(CreateLetterState(0, letterFileName, dropdownItems));
            emit(UpdateTenantBackOption());
          }
        } catch (e) {
          if (kDebugMode) {
            print('invoice submit error');
            print('invoice submit error is $e');
          }
          emit(
            UpdateTenantState(
              nameTenantUpdate,
              numberTenantUpdate,
              officialEmailTenantUpdate,
              aboutTenantUpdate,
              floorTenantUpdate,
              sizeTenantUpdate,
              rentTenantUpdate,
              escalationTenantUpdate,
              poboxTenantUpdate,
              leaseStartDateTenantUpdate,
              leaseEndDateTenantUpdate,
              activeTenantUpdate,
              0,
            ),
          );
        }
      },
    );

    // ----------------------------------------------------------
    // ----------- Delete Letters----------------------------
    // ----------------------------------------------------------

    on<DeleteLetterRequestEvent>(
      (event, emit) async {
        if (kDebugMode) {
          print('update invoice');
        }
        letterDeleteId = event.id;

        if (kDebugMode) {
          print('details are');
          print(letterDeleteId);
        }
        emit(DeleteLetterRequestState());
      },
    );
    //

    on<DeleteLetterEvent>(
      (event, emit) async {
        if (kDebugMode) {
          print('update invoice');
        }
        // letterDeleteId = event.id;
        // DeleteLetterSuccessLoadingState
        emit(DeleteLetterSuccessLoadingState());
        // emit(DeleteLetterSuccessState(1));
        if (kDebugMode) {
          print('details are');
          print(letterDeleteId);
        }
        // emit(DeleteLetterRequestState());
        try {
          final deleteLetter = await _client.deleteLetter(id: letterDeleteId);
          if (deleteLetter!.status == 200) {
            emit(DeleteLetterSuccessState());
          }
        } catch (e) {
          if (kDebugMode) {
            print("error is $e");
            emit(DeleteLetterRequestState());
          }
        }
      },
    );

    // ----------------------------------------------------------
    // ----------- Delete Letters----------------------------
    // ----------------------------------------------------------

    on<DeleteInvoiceRequestEvent>(
      (event, emit) async {
        if (kDebugMode) {
          print('update invoice');
        }
        invoiceDeleteId = event.id;

        if (kDebugMode) {
          print('details are');
          print(invoiceDeleteId);
        }
        emit(DeleteInvoiceRequestState());
      },
    );

    on<DeleteInvoiceEvent>(
      (event, emit) async {
        if (kDebugMode) {
          print('delete invoice');
        }
        // letterDeleteId = event.id;
        // DeleteLetterSuccessLoadingState
        emit(DeleteInvoiceSuccessLoadingState());
        // emit(DeleteLetterSuccessState(1));
        if (kDebugMode) {
          print('details are');
          print(invoiceDeleteId);
        }
        // emit(DeleteLetterRequestState());
        try {
          final deleteInvoice =
              await _client.deleteInvoice(id: invoiceDeleteId);
          if (deleteInvoice!.status == 200) {
            emit(DeleteInvoiceSuccessState());
          }
        } catch (e) {
          if (kDebugMode) {
            print("error is $e");
            emit(DeleteInvoiceRequestState());
          }
        }
      },
    );
    // invoiceDeleteId

    // ----------------------------------------------------------
    // ----------- Delete Statement ----------------------------
    // ----------------------------------------------------------

    on<DeleteStatementRequestEvent>(
      (event, emit) async {
        if (kDebugMode) {
          print('update invoice');
        }
        statementDeleteId = event.id;

        if (kDebugMode) {
          print('details are');
          print(statementDeleteId);
        }
        emit(DeleteStatementRequestState());
      },
    );

    on<DeleteStatementEvent>(
      (event, emit) async {
        if (kDebugMode) {
          print('delete statement');
        }
        // letterDeleteId = event.id;
        // DeleteLetterSuccessLoadingState
        emit(DeleteStatementSuccessLoadingState());
        // emit(DeleteLetterSuccessState(1));
        if (kDebugMode) {
          print('details are');
          print(statementDeleteId);
        }
        // emit(DeleteLetterRequestState());
        try {
          final deleteStatement =
              await _client.deleteStatement(id: statementDeleteId);
          if (deleteStatement!.status == 200) {
            emit(DeleteStatementSuccessState());
          }
        } catch (e) {
          if (kDebugMode) {
            print("error is $e");
            emit(DeleteStatementRequestState());
          }
        }
      },
    );

    // ----------------------------------------------------------
    // ----------- Delete Tenant ----------------------------
    // ----------------------------------------------------------

    on<DeleteTenantRequestEvent>(
      (event, emit) async {
        if (kDebugMode) {
          print('update invoice');
        }
        tenantDeleteId = event.id;

        if (kDebugMode) {
          print('details are');
          print(tenantDeleteId);
        }
        emit(DeleteTenantRequestState());
      },
    );

    on<DeleteTenantEvent>(
      (event, emit) async {
        if (kDebugMode) {
          print('delete statement');
        }
        // letterDeleteId = event.id;
        // DeleteLetterSuccessLoadingState
        emit(DeleteTenantSuccessLoadingState());
        // emit(DeleteLetterSuccessState(1));
        if (kDebugMode) {
          print('details are');
          print(tenantDeleteId);
        }
        // emit(DeleteLetterRequestState());
        try {
          final deleteTenant = await _client.deleteTenant(id: tenantDeleteId);
          if (deleteTenant!.status == 200) {
            emit(DeleteTenantSuccessState());
          }
        } catch (e) {
          if (kDebugMode) {
            print("error is $e");
            emit(DeleteTenantRequestState());
          }
        }
      },
    );
  }
}
