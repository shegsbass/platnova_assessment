import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MappingException implements Exception {}

class NoInternetConnectionException extends DioError {
  Response<dynamic>? res;

  NoInternetConnectionException(RequestOptions requestOptions)
      : super(requestOptions: requestOptions);

  @override
  String toString() {
    return json.encode({
      "message": 'Check your internet connection and try again.',
      "error": "No Internet"
    });
  }
}

class UnknownException extends DioError {
  Response<dynamic>? res;

  UnknownException({this.res, required RequestOptions requestOptions})
      : super(response: res, requestOptions: requestOptions);
  @override
  String toString() {
    print("Samooe $res");
    return json.encode(res);
  }
}

class InternalServerErrorException extends DioError {
  Response<dynamic>? res;

  InternalServerErrorException(
      {this.res, required RequestOptions requestOptions})
      : super(response: res, requestOptions: requestOptions);
  @override
  String toString() {
    return json.encode(res?.data);
  }
}

class ConflictException extends DioError {
  Response<dynamic>? res;

  ConflictException({this.res, required RequestOptions requestOptions})
      : super(response: res, requestOptions: requestOptions);
  @override
  String toString() {
    debugPrint("Here type ${res.runtimeType}");
    debugPrint("Here data ${res?.data}");
    debugPrint("Here message ${res?.statusMessage}");
    return res.toString();
    // return json.encode(res);
  }
}

class UnprocessableContent extends DioError {
  Response<dynamic>? res;

  UnprocessableContent({this.res, required RequestOptions requestOptions})
      : super(response: res, requestOptions: requestOptions);
  @override
  String toString() {
    return res.toString();
    //return json.encode(res);
  }
}

class InvalidUserInput extends DioError {
  Response<dynamic>? res;

  InvalidUserInput({this.res, required RequestOptions requestOptions})
      : super(response: res, requestOptions: requestOptions);
  @override
  String toString() {
    return res.toString();
  }
}

class NotFoundException extends DioError {
  Response<dynamic>? res;

  NotFoundException({this.res, required RequestOptions requestOptions})
      : super(response: res, requestOptions: requestOptions);
  @override
  String toString() {
    return res?.toString() ?? "";
  }
}

class UnauthorizedException extends DioError {
  Response<dynamic>? res;

  UnauthorizedException({this.res, required RequestOptions requestOptions})
      : super(response: res, requestOptions: requestOptions);
  @override
  String toString() {
    return res.toString();
  }
}

class BadRequestException extends DioError {
  Response<dynamic>? res;

  BadRequestException({this.res, required RequestOptions requestOptions})
      : super(response: res, requestOptions: requestOptions);
  @override
  String toString() {
    return res.toString();
  }
}

class ConnectTimeoutException extends DioError {
  Response<dynamic>? res;

  ConnectTimeoutException({this.res, required RequestOptions requestOptions})
      : super(response: res, requestOptions: requestOptions);

  @override
  String toString() {
    return jsonEncode({
      "message": 'The connection has timed out.\nplease try again.',
      "error": "Connection Timeout"
    });
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions requestOptions)
      : super(requestOptions: requestOptions);
  @override
  String toString() {
    return {
      "message": 'The connection has timed out.\nplease try again.',
      "error": "Connection Timeout"
    }.toString();
  }
}
