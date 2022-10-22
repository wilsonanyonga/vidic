import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:vidic/models/jwt.dart';
import 'package:vidic/models/statement/get_statement.dart';
import 'package:vidic/utils/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  String? stringValue;
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://127.0.0.1:8010/api',
      // baseUrl: 'https://go.khostess.co.ke/api',
      // baseUrl: 'https://mwambaapp.mwambabuilders.com/mwambaApp/api',
      connectTimeout: 5000,
      receiveTimeout: 3000,
      // headers: {
      //   "Access-Control-Allow-Origin": "*",
      //   "Access-Control-Allow-Headers": "Content-Type, Authorization",
      //   "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE,PATCH",
      //   "Content-Type": "application/json",
      // },
    ),
  )..interceptors.add(Logging());

  Future<Jwt?> getToken(email) async {
    Jwt? mpesaPay;

    try {
      Response userData = await _dio.post(
        '/getJWT',
        data: {
          "email": email,
          // "amount": amount.toString(),
        },
      );

      if (kDebugMode) {
        print('User Info: ${userData.toString()}');
      }

      mpesaPay = Jwt.fromJson(userData.data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        if (kDebugMode) {
          print('Dio error!');
          print('STATUS: ${e.response?.statusCode}');
          print('DATA: ${e.response?.data}');
          print('HEADERS: ${e.response?.headers}');
        }
      } else {
        // Error due to setting up or sending the request
        if (kDebugMode) {
          print('Error sending request!');
          print(e.message);
        }
      }
    }

    return mpesaPay;
  }

  Future<GetStatement?> getStatement() async {
    GetStatement? user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    stringValue = prefs.getString('jwt_token');
    if (kDebugMode) {
      print(stringValue);
    }
    try {
      // _dio.options.headers[HttpHeaders.authorizationHeader] = "stringValue";
      Response userData = await _dio.get(
        '/getStatement',
        options: Options(
          headers: {
            // "authorization": stringValue, // set content-length
            "Authorization": stringValue, // set content-length
            // "Content-Type": "application/json",
            // 'Accept': '*/*',
            // "Access-Control-Allow-Origin": "*",
            // "Access-Control-Allow-Headers": "Content-Type, Authorization",
            // "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE,PATCH",
            // "Content-Type": "application/json",
          },
        ),
      );

      if (kDebugMode) {
        print('User Info: ${userData.data}');
      }

      user = GetStatement.fromJson(userData.data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        if (kDebugMode) {
          print('Dio error!');
          print('STATUS: ${e.response?.statusCode}');
          print('DATA: ${e.response?.data}');
          print('HEADERS: ${e.response?.headers}');
        }
      } else {
        // Error due to setting up or sending the request
        if (kDebugMode) {
          print('Error sending request!');
          print(e.message);
        }
      }
    }

    return user;
  }
}
