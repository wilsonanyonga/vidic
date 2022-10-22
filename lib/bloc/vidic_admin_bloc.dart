import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidic/models/statement/get_statement.dart';
import 'package:vidic/models/statement/get_statement_data.dart';
import 'package:vidic/utils/auth.dart';
import 'package:vidic/utils/dio_client.dart';

part 'vidic_admin_event.dart';
part 'vidic_admin_state.dart';

class VidicAdminBloc extends Bloc<VidicAdminEvent, VidicAdminState> {
  final DioClient _client = DioClient();
  Dio dio = Dio();

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
    // ----------- STATEMENT --------------------------------
    // ------------------------------------------------------------------------------------------

    on<StatementGetEvent>((event, emit) async {
      // TODO: implement event handler
      emit(StatementLoading());
      await Future.delayed(const Duration(seconds: 2));
      final statements = await _client.getStatement();
      emit(StatementLoaded(statements!.data));
    });

    // ------------------------------------------------------------------------------------------------------------
    // ----------- STATEMENT END--------------------------------
    // ------------------------------------------------------------------------------------------
  }
}
