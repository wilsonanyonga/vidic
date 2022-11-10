import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
      // delay for token to be stored well in shared preferences
      await Future.delayed(const Duration(seconds: 1));

      final statements = await _client.getTenants();

      final occupancy = await _client.getOccupancy();

      if (kDebugMode) {
        print("hehe");
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

    // ----------- Letter Complaint --------------------------------

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

    // ----------- Letter Complaint END--------------------------------

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
    on<CreateStatementEvent>((event, emit) {
      emit(CreateStatementState(0));
    });
    // ----------- END Create New Statement ----------------------------
  }
}
