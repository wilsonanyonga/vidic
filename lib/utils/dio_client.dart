import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:vidic/models/invoice/get_invoice.dart';
import 'package:vidic/models/invoice/post/post_invoice.dart';
import 'package:vidic/models/jwt.dart';
import 'package:vidic/models/landing/post/post_tenant.dart';
import 'package:vidic/models/landing/tenants.dart';
import 'package:vidic/models/letter/get_letter.dart';
import 'package:vidic/models/letter/post/post_letter.dart';
import 'package:vidic/models/occupancy/get_occupancy.dart';
import 'package:vidic/models/occupancy/update/update_occupancy.dart';
import 'package:vidic/models/statement/get_statement.dart';
import 'package:vidic/models/statement/post/post_statement.dart';
import 'package:vidic/models/tenant_letter/get_tenant_letter.dart';
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
        // options: Options(
        //   headers: {
        //     // "authorization": stringValue, // set content-length
        //     "Authorization": '', // set content-length
        //     // "Content-Type": "application/json",
        //     // 'Accept': '*/*',
        //     // "Access-Control-Allow-Origin": "*",
        //     // "Access-Control-Allow-Headers": "Content-Type, Authorization",
        //     // "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE,PATCH",
        //     // "Content-Type": "application/json",
        //   },
        // ),
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

  // get tenants
  Future<GetTenant?> getTenants() async {
    GetTenant? user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    stringValue = prefs.getString('jwt_token');
    if (kDebugMode) {
      print(stringValue);
    }
    try {
      // _dio.options.headers[HttpHeaders.authorizationHeader] = "stringValue";
      Response userData = await _dio.get(
        '/getTenant',
        options: Options(
          headers: {
            // "authorization": stringValue, // set content-length
            "authorization": stringValue, // set content-length
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

      user = GetTenant.fromJson(userData.data);
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

  // get statement
  Future<GetStatement?> getStatement() async {
    GetStatement? user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    stringValue = prefs.getString('jwt_token');
    if (kDebugMode) {
      print(stringValue);
    }
    try {
      Response userData = await _dio.get(
        '/getStatement',
        options: Options(
          headers: {
            // "authorization": stringValue, // set content-length
            "authorization": stringValue, // set content-length
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

  // get Invoice
  Future<GetInvoice?> getInvoice() async {
    GetInvoice? user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    stringValue = prefs.getString('jwt_token');
    if (kDebugMode) {
      print(stringValue);
    }
    try {
      Response userData = await _dio.get(
        '/getInvoices',
        options: Options(
          headers: {
            "authorization": stringValue, // set content-length
          },
        ),
      );

      if (kDebugMode) {
        print('User Info: ${userData.data}');
      }

      user = GetInvoice.fromJson(userData.data);
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

  // get Letters
  Future<GetLetter?> getLetter() async {
    GetLetter? user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    stringValue = prefs.getString('jwt_token');
    if (kDebugMode) {
      print(stringValue);
    }
    try {
      // _dio.options.headers[HttpHeaders.authorizationHeader] = "stringValue";
      Response userData = await _dio.get(
        '/getLetters',
        options: Options(
          headers: {
            "authorization": stringValue, // set content-length
          },
        ),
      );

      if (kDebugMode) {
        print('User Info: ${userData.data}');
      }

      user = GetLetter.fromJson(userData.data);
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

  // get tenant Letters
  Future<GetTenantLetter?> getTenantLetter() async {
    GetTenantLetter? user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    stringValue = prefs.getString('jwt_token');
    if (kDebugMode) {
      print(stringValue);
    }
    try {
      // _dio.options.headers[HttpHeaders.authorizationHeader] = "stringValue";
      Response userData = await _dio.get(
        '/getLettersTenant',
        options: Options(
          headers: {
            "authorization": stringValue, // set content-length
          },
        ),
      );

      if (kDebugMode) {
        print('User Info: ${userData.data}');
      }

      user = GetTenantLetter.fromJson(userData.data);
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

  // get tenant Letters
  Future<GetOccupancy?> getOccupancy() async {
    GetOccupancy? user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    stringValue = prefs.getString('jwt_token');
    if (kDebugMode) {
      print(stringValue);
    }
    try {
      // _dio.options.headers[HttpHeaders.authorizationHeader] = "stringValue";
      Response userData = await _dio.get(
        '/getOccupancy',
        options: Options(
          headers: {
            "authorization": stringValue, // set content-length
          },
        ),
      );

      if (kDebugMode) {
        print('User Info: ${userData.data}');
      }

      user = GetOccupancy.fromJson(userData.data);
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

// --------------------------------------------------------------------------
// ------------- CREATE-----------------------
// --------------------------------------------------------------------------

  Future<PostTenant?> createTenant({
    required String name,
    required String number,
    required String officialEmail,
    required String about,
    String? floor,
    required String size,
    required String rent,
    required String escalation,
    required String pobox,
    String? leaseStartDate,
    String? leaseEndDate,
    required String active,
    // required PostTenant createTenant,
    // required String name,
    // required String number,
    // required String email,
    // required String role,
    // required bool paid,
    // required bool active,
    // String? picture,
    // String? picture2,
    // String? picture3,
    // String? picture4,
  }) async {
    PostTenant? createTenant;
    // print(imageFile);
    if (kDebugMode) {
      // print(us2.toJson());
      print("object is testing............");
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    stringValue = prefs.getString('jwt_token');
    try {
      // var formData = FormData.fromMap({
      //   'name': us2.name,
      //   'number': us2.number,
      //   'email': us2.email,
      //   'role': us2.role,
      //   'age': us2.age,
      //   'about': us2.about,
      //   'location': us2.location,
      //   // 'password': us2.password,
      //   'paid': us2.paid,
      //   'active': us2.active,
      //   'file': await MultipartFile.fromFile('${us2.picture}',
      //       filename: 'upload.png'),
      //   'file2': await MultipartFile.fromFile('${us2.picture2}',
      //       filename: 'upload2.png'),
      //   'file3': await MultipartFile.fromFile('${us2.picture3}',
      //       filename: 'upload3.png'),
      //   'file4': await MultipartFile.fromFile('${us2.picture4}',
      //       filename: 'upload4.png'),
      // });
      // print(formData);

      if (kDebugMode) {
        print("object is here");
      }
      Response response = await _dio.post(
        '/postTenant',
        options: Options(
          headers: {
            "authorization": stringValue, // set content-length
          },
        ),
        data: {
          "name": name,
          "number": number,
          "vidic_email": "vidic@vidic.co.ke",
          "official_email": officialEmail,
          "about": about,
          "floor": floor,
          "size": size,
          "rent": rent,
          "escalation": escalation,
          "pobox": pobox,
          "lease_start_date": leaseStartDate,
          "lease_end_date": leaseEndDate,
          "active": active
        },
      );

      if (kDebugMode) {
        print('User created: ${response.data['data']}');
        print("object is creating............");
      }

      createTenant = PostTenant.fromJson(response.data);
    } catch (e) {
      if (kDebugMode) {
        print('Error creating user: $e');
      }
    }

    return createTenant;
  }

  // create new statement
  Future<PostStatement?> createStatement({
    String? tenantStatementName,
    String? amount,
    String? statementStartDate,
    String? statementEndDate,
    Uint8List? statementFile,
    // String? floor,
  }) async {
    PostStatement? createStatement;
    // print(imageFile);
    if (kDebugMode) {
      // print(us2.toJson());
      print("object is testing............");
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    stringValue = prefs.getString('jwt_token');
    try {
      var formData = FormData.fromMap({
        'file_statement': MultipartFile.fromBytes(statementFile!.toList(),
            filename: 'upload.pdf'),
        // 'file_statement': statementFile,
        'start_date': statementStartDate,
        'end_date': statementEndDate,
        'amount': amount,
        'tenant_id': tenantStatementName
      });
      if (kDebugMode) {
        print(formData);
      }

      if (kDebugMode) {
        print("object is here");
      }
      Response response = await _dio.post(
        '/postStatement',
        options: Options(
          headers: {
            "authorization": stringValue, // set content-length
          },
        ),
        data: formData,
      );

      if (kDebugMode) {
        print('User created: ${response.data}');
        print("statement is creating............");
      }

      createStatement = PostStatement.fromJson(response.data);
    } catch (e) {
      if (kDebugMode) {
        print('Error creating user: $e');
      }
    }

    return createStatement;
  }

  // create new invoice
  Future<PostInvoice?> createInvoice({
    String? tenantInvoiceId,
    String? amount,
    String? purpose,
    String? invoiceMonth,
    Uint8List? invoiceFile,
    // String? floor,
  }) async {
    PostInvoice? createInvoice;
    // print(imageFile);
    if (kDebugMode) {
      // print(us2.toJson());
      print("object is testing............");
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    stringValue = prefs.getString('jwt_token');
    try {
      var formData = FormData.fromMap({
        'file_invoice': MultipartFile.fromBytes(invoiceFile!.toList(),
            filename: 'upload.pdf'),
        // 'file_statement': statementFile,
        'month': invoiceMonth,
        'amount': amount,
        'purpose': purpose,
        'tenant_id': tenantInvoiceId
      });
      if (kDebugMode) {
        print(formData);
      }

      if (kDebugMode) {
        print("object is here");
      }
      Response response = await _dio.post(
        '/postInvoice',
        options: Options(
          headers: {
            "authorization": stringValue, // set content-length
          },
        ),
        data: formData,
      );

      if (kDebugMode) {
        print('User created: ${response.data}');
        print("statement is creating............");
      }

      createInvoice = PostInvoice.fromJson(response.data);
    } catch (e) {
      if (kDebugMode) {
        print('Error creating user: $e');
      }
    }

    return createInvoice;
  }

  // create new letter
  Future<PostLetter?> createLetter({
    String? tenantLetterId,
    String? subject,
    String? date,
    Uint8List? letterFile,
  }) async {
    PostLetter? createLetter;
    // print(imageFile);
    if (kDebugMode) {
      // print(us2.toJson());
      print("object is testing............");
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    stringValue = prefs.getString('jwt_token');
    try {
      var formData = FormData.fromMap({
        'file_letter': MultipartFile.fromBytes(letterFile!.toList(),
            filename: 'upload.pdf'),
        'tenant_id': tenantLetterId,
        'subject': subject,
        'date': date,
      });
      if (kDebugMode) {
        print(formData);
      }

      if (kDebugMode) {
        print("object is here");
      }
      Response response = await _dio.post(
        '/postLetter',
        options: Options(
          headers: {
            "authorization": stringValue, // set content-length
          },
        ),
        data: formData,
      );

      if (kDebugMode) {
        print('User created: ${response.data}');
        print("letter is creating............");
      }

      createLetter = PostLetter.fromJson(response.data);
    } catch (e) {
      if (kDebugMode) {
        print('Error creating user: $e');
      }
    }

    return createLetter;
  }

  // update occupancy
  Future<UpdateOccupancy?> updateOccupancy({
    String? occupancy,
    String? capacity,
    int? floorId,
  }) async {
    UpdateOccupancy? updateOccupancy;
    // print(imageFile);
    if (kDebugMode) {
      // print(us2.toJson());
      print("object is testing............");
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    stringValue = prefs.getString('jwt_token');
    try {
      // var formData = FormData.fromMap({
      //   'file_letter': MultipartFile.fromBytes(letterFile!.toList(),
      //       filename: 'upload.pdf'),
      //   'tenant_id': tenantLetterId,
      //   'subject': subject,
      //   'date': date,
      // });
      // if (kDebugMode) {
      //   print(formData);
      // }

      if (kDebugMode) {
        print("object is here, $occupancy, $capacity, $floorId");
      }
      Response response = await _dio.patch(
        '/updateOccupancy/$floorId',
        options: Options(
          headers: {
            "authorization": stringValue, // set content-length
          },
        ),
        data: {
          "capacity": int.parse(capacity!),
          "occupancy": int.parse(occupancy!),
          // "capacity": "10",
          // "occupancy": 12,
        },
      );

      if (kDebugMode) {
        print('User created: ${response.data}');
        print("letter is creating............");
      }

      updateOccupancy = UpdateOccupancy.fromJson(response.data);
    } catch (e) {
      if (kDebugMode) {
        print('Error creating user: $e');
      }
    }

    return updateOccupancy;
  }

  // update letter
  Future<PostLetter?> updateLetter({
    int? id,
    // String? tenantLetterId,
    String? subject,
    String? date,
    Uint8List? letterFile,
  }) async {
    PostLetter? updateLetter;
    // print(imageFile);
    if (kDebugMode) {
      // print(us2.toJson());
      print("object is testing............");
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    stringValue = prefs.getString('jwt_token');
    try {
      var formData = FormData.fromMap({
        'file_letter': letterFile != null
            ? MultipartFile.fromBytes(letterFile.toList(),
                filename: 'upload.pdf')
            : null,
        // 'tenant_id': tenantLetterId,
        'subject': subject,
        'date': date,
      });
      if (kDebugMode) {
        print(formData);
      }

      Response response = await _dio.patch(
        '/updateLetter/$id',
        options: Options(
          headers: {
            "authorization": stringValue, // set content-length
          },
        ),
        data: formData,
      );

      if (kDebugMode) {
        print('User created: ${response.data}');
        print("letter is creating............");
      }

      updateLetter = PostLetter.fromJson(response.data);
    } catch (e) {
      if (kDebugMode) {
        print('Error creating user: $e');
      }
    }

    return updateLetter;
  }

  // update invoice
  Future<PostInvoice?> updateInvoice({
    // String? tenantInvoiceId,
    int? id,
    String? amount,
    String? purpose,
    String? invoiceMonth,
    Uint8List? invoiceFile,
    // String? floor,
  }) async {
    PostInvoice? createInvoice;
    // print(imageFile);
    if (kDebugMode) {
      // print(us2.toJson());
      print("object is testing............");
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    stringValue = prefs.getString('jwt_token');
    try {
      var formData = FormData.fromMap({
        'file_invoice': invoiceFile != null
            ? MultipartFile.fromBytes(invoiceFile.toList(),
                filename: 'upload.pdf')
            : null,
        // 'file_statement': statementFile,
        'month': invoiceMonth,
        'amount': amount,
        'purpose': purpose,
        // 'tenant_id': tenantInvoiceId
      });
      if (kDebugMode) {
        print(formData);
      }

      if (kDebugMode) {
        print("object is here");
      }
      Response response = await _dio.patch(
        '/updateInvoice/$id',
        options: Options(
          headers: {
            "authorization": stringValue, // set content-length
          },
        ),
        data: formData,
      );

      if (kDebugMode) {
        print('User created: ${response.data}');
        print("statement is creating............");
      }

      createInvoice = PostInvoice.fromJson(response.data);
    } catch (e) {
      if (kDebugMode) {
        print('Error creating user: $e');
      }
    }

    return createInvoice;
  }

  // update statement
  Future<PostStatement?> updateStatement({
    String? tenantStatementName,
    String? amount,
    String? statementStartDate,
    String? statementEndDate,
    Uint8List? statementFile,
    // String? floor,
  }) async {
    PostStatement? createStatement;
    // print(imageFile);
    if (kDebugMode) {
      // print(us2.toJson());
      print("object is testing............");
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    stringValue = prefs.getString('jwt_token');
    try {
      var formData = FormData.fromMap({
        'file_statement': MultipartFile.fromBytes(statementFile!.toList(),
            filename: 'upload.pdf'),
        // 'file_statement': statementFile,
        'start_date': statementStartDate,
        'end_date': statementEndDate,
        'amount': amount,
        'tenant_id': tenantStatementName
      });
      if (kDebugMode) {
        print(formData);
      }

      if (kDebugMode) {
        print("object is here");
      }
      Response response = await _dio.patch(
        '/updateStatement',
        options: Options(
          headers: {
            "authorization": stringValue, // set content-length
          },
        ),
        data: formData,
      );

      if (kDebugMode) {
        print('User created: ${response.data}');
        print("statement is creating............");
      }

      createStatement = PostStatement.fromJson(response.data);
    } catch (e) {
      if (kDebugMode) {
        print('Error creating user: $e');
      }
    }

    return createStatement;
  }
}
