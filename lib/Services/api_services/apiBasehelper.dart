import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';

import 'apiConstants.dart';

class ApiException implements Exception {
  ApiException(this.errorMessage);

  String errorMessage;

  @override
  String toString() {
    return errorMessage;
  }
}

class ApiBaseHelper {

  Future<dynamic> postAPICall(Uri url, Map param) async {
    var responseJson;
    log('${url}');
    log('${param}');

    try {
      final response =
      await post(url, body: param.isNotEmpty ? param : [], headers: headers)
          .timeout(const Duration(seconds: timeOut));
      log('${response.body}');
      responseJson = _response(response);
    } on SocketException catch (e) {
      throw ApiException('No Internet connection');
    } on TimeoutException {
      throw ApiException('Something went wrong, Server not Responding');
    } on Exception catch (e) {
      throw ApiException('Something Went wrong with ${e.toString()}');
    }
    return responseJson;
  }


  Future<dynamic> postAPICall2(Uri url) async {
    var responseJson;
    log('${url}');

    try {
      final response =
      await post(url, headers: headers)
          .timeout(const Duration(seconds: timeOut));
      log('${response.body}');
      responseJson = _response(response);
    } on SocketException catch (e) {
      throw ApiException('No Internet connection');

    } on TimeoutException {
      throw ApiException('Something went wrong, Server not Responding');
    } on Exception catch (e) {
      throw ApiException('Something Went wrong with ${e.toString()}');
    }
    return responseJson;
  }

  Future<dynamic> getAPICall(Uri url) async {
    var responseJson;
    log('${url}');
    try {
      final response =
      await get(url, headers: headers)
          .timeout(const Duration(seconds: timeOut));

      log('${response.statusCode}');

      responseJson = _response(response);
    } on SocketException catch (e) {
      throw ApiException('No Internet connection');
    } on TimeoutException {
      throw ApiException('Something went wrong, Server not Responding');
    } on Exception catch (e) {
      throw ApiException('Something Went wrong with ${e.toString()}');
    }
    return responseJson;
  }



  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }
}

class CustomException implements Exception {
  final message;
  final prefix;

  CustomException([this.message, this.prefix]);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([message])
      : super(message, 'Error During Communication: ');
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, 'Unauthorised: ');
}

class InvalidInputException extends CustomException {
  InvalidInputException([message]) : super(message, 'Invalid Input: ');
}
Map<String, String> get headers => {
  'Cookie': 'ci_session=3a2ad9ed3b163b1b2873213952605317b83816b3',
};