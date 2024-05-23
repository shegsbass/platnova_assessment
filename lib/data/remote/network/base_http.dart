// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


import '../../../di/injection_container.dart';
import '../../../presentation/util/data_utils/storage/shared_preference.dart';
import 'api_services.dart';
import 'errors.dart';

abstract class Endpoint {
  Endpoint(this.method, String url, [this.validStatusCode]) : _url = url;

  final String method;
  final int? validStatusCode;

  final String _url;

  String get url => domainUrl + _url;

  String get domainUrl;

  FutureOr<T?> hit<T>({
    Map<String, dynamic>? queryParameters,
    Object? data,
    String? urlData,
    Map<String, dynamic>? headers,
    T Function(dynamic responseBody)? map,
    Function(String errorMessage)? onError,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool isMultipart = false,
    bool isAuthenticated = true,
  }) async {
    T? result;

    if (!await _checkConnection()) {
      log('Unable to connect to the internet', name: "$method $_url");
      log('🛎️🛎️🛎️ Internet Connection Issue 🛎️🛎️🛎️', name: "$method $_url");
      onError?.call('Please check your connection and try again!');
      return null;
    }

    try {
      final Response response = await _sendRequest(
        urlData,
        queryParameters,
        data,
        headers,
        onSendProgress,
        onReceiveProgress,
        isMultipart,
        isAuthenticated,
      );

      try {
        result = map?.call(response.data) ?? response.data;
        log('✔️✔️✔️ Mapping Successful ✔️✔️✔️ -- $result', name: "$method $_url");
      } catch (e, s) {
        log('RESPONSE DATA: \n${response.data}', name: "$method $_url");
        log("EXCEPTION: $e", name: "$method $_url");
        log("ST: $s", name: "$method $_url");
        throw MappingException();
      }
    } on DioError catch (e) {
      rethrow;
      _logError(e);

      try {
        final errorMessage = e.response?.data['message'] ?? 'An unknown error occurred';
        onError?.call(errorMessage);
      } catch (er) {
        onError?.call('An unknown error occurred');
      }
      log('❌❌❌ Request Error ❌❌❌', name: "$method $_url");
    } on MappingException {
      log('An error occurred while mapping response to $T', name: "$method $_url");
      onError?.call('An error occurred while mapping response to $T');
      log('❌❌❌ Mapping Error ❌❌❌', name: "$method $_url");
      result = null;
    } catch (e) {
      log(e.toString(), name: "$method $_url");
      onError?.call(e.toString());
      log('❌❌❌ Unknown Error ❌❌❌', name: "$method $_url");
    }
    return result;
  }

  Future<Response> _sendRequest(
    String? urlData,
    Map<String, dynamic>? queryParameters,
    Object? data,
    Map<String, dynamic>? headers,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool isMultipart,
    bool isAuthenticated,
  ) {
    PlatnovaBaseHttpService httpService = PlatnovaBaseHttpService(
      isAuth: isAuthenticated,
    );
    httpService.http.options.method = method;

    final dioRequest = isMultipart ? _buildMultipartRequest(data) : _buildRequest(data);

    return httpService.http.request(url + (urlData ?? ""),
        data: dioRequest,
        queryParameters: queryParameters,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }

  dynamic _buildMultipartRequest(Object? data) {
    if (data.runtimeType != FormData) {
      throw ArgumentError("isMultipart is set to true but data is not of type FormData");
    }

    final formData = data as FormData;
    final dataMap = <String, dynamic>{}..addEntries(formData.fields);
    final filesMap = <String, MultipartFile>{}..addEntries(formData.files);

    log('DATA: $dataMap', name: "$method $_url");
    log(
      'Files: ${{for (var k in filesMap.keys) k: filesMap[k]!.filename}}, name: "$method $_url"',
    );

    return formData;
  }

  dynamic _buildRequest(Object? data) {
    return data;
  }

  void _logError(DioError e) {
    if (e.response != null) {
      log('RESPONSE STATUS: \n${e.response?.statusCode}', name: "$method $_url");
      log('RESPONSE DATA: \n${e.response?.data}', name: "$method $_url");
      log('RESPONSE HEADERS: \n${e.response?.headers}', name: "$method $_url");
    } else {
      log('Error sending request!', name: "$method $_url");
      log(e.message ?? "", error: e, name: "$method $_url");
    }
  }

  Future<bool> _checkConnection() async {
    const endpoint = 'https://sandbox.api.service.nhs.uk/hello-world/hello/world';
    try {
      final Response response =
          await PlatnovaBaseHttpService(hideLogs: true, isAuth: false).http.get(endpoint);
      return response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }
}

class PlatnovaBaseHttpService {
  late Dio http;

  Map<String, dynamic> headers = {
    "accept": "text/plain",
    "Content-Type": "application/json",
    "clientid": "123456",
    "clientsecret": "123456",
  };

  PlatnovaBaseHttpService({bool hideLogs = false, isAuth}) {
    http = Dio(BaseOptions(
        baseUrl: ApiServices.baseUrl,
        connectTimeout: const Duration(milliseconds: 30 * 1000),
        receiveTimeout: const Duration(milliseconds: 30 * 1000),
        sendTimeout: const Duration(milliseconds: 30 * 1000),
        headers: headers));
    http.interceptors.addAll({AppInterceptors(dio: http, hideLogs: hideLogs, isAuth: isAuth)});
  }
}

class AppInterceptors extends Interceptor {
  final Dio dio;
  final bool hideLogs;
  final isAuth;

  AppInterceptors({required this.dio, required this.hideLogs, this.isAuth});

  LocalDataSource localDataSource = sl();

  String? token;

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(err.type.toString());
    switch (err.type) {
      case DioErrorType.connectionTimeout:
        throw ConnectTimeoutException(res: err.response, requestOptions: err.requestOptions);
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.badResponse:
        print("Base Http - Error status code: ${err.response?.statusCode}");
        switch (err.response?.statusCode) {
          case 302:
            throw InvalidUserInput(res: err.response, requestOptions: err.requestOptions);
          case 400:
            throw BadRequestException(res: err.response, requestOptions: err.requestOptions);
          case 401:
            // LogOut.forceSignOut();
            throw UnauthorizedException(res: err.response, requestOptions: err.requestOptions);
          case 403:
            throw UnauthorizedException(res: err.response, requestOptions: err.requestOptions);
          case 404:
            throw NotFoundException(res: err.response, requestOptions: err.requestOptions);
          case 405:
            throw NotFoundException(res: err.response, requestOptions: err.requestOptions);
          case 409:
            throw ConflictException(res: err.response, requestOptions: err.requestOptions);
          case 422:
            throw UnprocessableContent(res: err.response, requestOptions: err.requestOptions);
          case 500:
            throw InternalServerErrorException(
                res: err.response, requestOptions: err.requestOptions);
          case 501:
            throw InternalServerErrorException(
                res: err.response, requestOptions: err.requestOptions);
          case 502:
            throw InternalServerErrorException(
                res: err.response, requestOptions: err.requestOptions);
          case 503:
            throw InternalServerErrorException(
                res: err.response, requestOptions: err.requestOptions);
          case 504:
            throw InternalServerErrorException(
                res: err.response, requestOptions: err.requestOptions);
          default:
            throw UnknownException(res: err.response, requestOptions: err.requestOptions);
        }
      case DioErrorType.cancel:
        break;
      case DioErrorType.unknown:
        // throw UnknownException(
        //     res: err.response, requestOptions: err.requestOptions);

        throw NoInternetConnectionException(err.requestOptions);
        break;
      case DioExceptionType.badCertificate:
        // TODO: Handle this case.
        break;
      case DioExceptionType.connectionError:
        // TODO: Handle this case.
        break;
    }
    return handler.next(err);
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    token = localDataSource.getData(name: "accessToken");
    if (token != null && token != "" && isAuth) {
      options.headers.addAll({'Authorization': "Bearer $token"});
    }
    if (kDebugMode && !hideLogs) {
      // Logging
      log('➡️ ${options.uri.toString()}', name: "${options.method} ${options.path}");
      log('HEADERS: ${options.headers}', name: "${options.method} ${options.path}");
      log('QUERY PARAMETERS: ${options.queryParameters}',
          name: "${options.method} ${options.path}");
      if (options.data is Map) {
        log('DATA: ${jsonEncode(options.data)}', name: "${options.method} ${options.path}");
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    if (kDebugMode && !hideLogs) {
      // Logging
      log('➡️ ${response.statusCode}', name: "RESPONSE:: ${response.realUri.path}");
      log('RAW DATA: \n${jsonEncode(response.data)}', name: "RESPONSE:: ${response.realUri.path}");
    }
    handler.next(response);
  }
}
