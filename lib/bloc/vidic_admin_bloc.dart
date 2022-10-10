import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
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
    on<VidicLoginEvent>((event, emit) async {
      // TODO: implement event handler
      // if (await Auth().authStateChanges.isEmpty) {
      //   emit(Login());
      //   if (kDebugMode) {
      //     print('object1');
      //   }
      // }
      // if (kDebugMode) {
      //   print('object2');
      // }
    });
  }
}
