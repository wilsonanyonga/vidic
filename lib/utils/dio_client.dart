import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      // baseUrl: 'https://go.khostess.co.ke/api',
      baseUrl: 'https://mwambaapp.mwambabuilders.com/mwambaApp/api',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  );
}
