import 'package:dio/dio.dart';

const baseUrl = "http://localhost:8099/";

Dio appDio = Dio(BaseOptions(
  baseUrl: baseUrl,
  connectTimeout: 5000,
  receiveTimeout: 5000,
))
  ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

String imageUrl(String photo) => "$baseUrl/images/$photo";
