import 'dart:io';

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
import 'package:vidic/models/statement/get_statement.dart';
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

  String letterFileName = '';
  String? tenantLetterId;
  Uint8List? letterFile;

  // updating the letter
  String letterUpdateFileName = '';
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
      // TODO: implement event handler
      // emit(LoginState());
    });

    // ------------------------------------------------------------------------------------------------------------
    // ----------- Tenants List --------------------------------
    // ------------------------------------------------------------------------------------------

    on<TenantGetEvent>((event, emit) async {
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
      emit(CreateTenantState(0));
    });

    on<CreateFloorEvent>((event, emit) {
      floor = event.floor;
      if (kDebugMode) {
        print("$floor is state");
      }
      emit(CreateTenantState(0));
    });
    on<CreateStartDateEvent>((event, emit) {
      startDate = event.startDate;
      if (kDebugMode) {
        print("$startDate is state");
      }
      emit(CreateTenantState(0));
    });
    on<CreateEndDateEvent>((event, emit) {
      endDate = event.endDate;
      if (kDebugMode) {
        print("$endDate is state");
      }
      emit(CreateTenantState(0));
    });

    on<CreateTenantDataEvent>((event, emit) async {
      emit(CreateTenantState(1));
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
          emit(CreateTenantState(0));
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
  }
}
