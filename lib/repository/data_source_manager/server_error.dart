import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const String kSomethingWentWrong = 'Something went wrong';
const String kNoInternet = 'Please check your internet connection!';

class ServerError implements Exception {
  final int _errorCode = 0;
  String _errorMessage = kSomethingWentWrong;

  ServerError.withError({DioError? error}) {
    _handleError(error);
  }

  int get errorCode {
    return _errorCode;
  }

  Future<String> get errorMessage async {
    var isConnected = await checkConnection();
    if (!isConnected) {
      _errorMessage = kNoInternet;
    }
    return _errorMessage;
  }

  static Future<bool> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
      // Mobile network available.
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _handleError(DioError? error) async {
    debugPrint('#### error : $error');
    if (error == null) {
      _errorMessage = kSomethingWentWrong;
      return;
    }

    debugPrint('### API : ${error.requestOptions.uri}');
    debugPrint('### Method : ${error.requestOptions.method}');
    debugPrint('### Parameters : ${error.requestOptions.data}');
    debugPrint('### queryParameters : ${error.requestOptions.queryParameters}');
    debugPrint('### statusCode : ${error.response?.statusCode} ');
    debugPrint('### headers : ${error.requestOptions.headers} ');
    debugPrint('### statusMessage : ${error.response?.statusMessage} ');
    debugPrint('### response : ${error.response} ');
    debugPrint('### response.data : ${error.response?.data} ');
    debugPrint('### _handleError : ${error.toString()} ');

    switch (error.type) {
      case DioErrorType.cancel:
        _errorMessage = 'Request was cancelled';
        break;
      case DioErrorType.connectTimeout:
        _errorMessage = 'Connection timeout';
        break;
      case DioErrorType.other:
        if (error.response != null) {
          _errorMessage = error.response?.statusMessage ?? kSomethingWentWrong;
        }
        //_errorMessage = "Connection failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        _errorMessage = 'Receive timeout in connection';
        break;
      case DioErrorType.response:
        if (error.response != null) {
          var msg = _handleServerError(error.response);
          debugPrint('msg ---- > $msg');
          if (msg.isEmpty) {
            msg = error.toString();
          }
          _errorMessage = msg;
        }
        break;
      case DioErrorType.sendTimeout:
        _errorMessage = 'Receive timeout in send request';
        break;
    }

    if (_errorMessage.isEmpty) {
      _errorMessage = kSomethingWentWrong;
    }

    // return _errorMessage;
  }

  static String _handleServerError(response) {
    if (response == null) {
      return kSomethingWentWrong;
    }
    if (response.statusCode == 403) {
      // Get.offAllNamed(Routes.LOGIN);
    }
    if (response.statusCode == 401) {
      //logout user
      // LoginUser.instance.logout();
      Fluttertoast.showToast(
        msg: response.statusMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      //navigate to login page
      // Get.offAllNamed(Routes.userType, arguments: UserTypeLoinSingUp.loginUser);
    }

    if (response.statusCode == 400) {
      var map = response.data;

      return map['message'] ?? kSomethingWentWrong;
    }

    if (response.statusMessage != null && !response.statusMessage.isEmpty) {
      return response.statusMessage;
    }

    if (response != null && response.runtimeType == String) {
      return response.toString();
    }
    if (response.users != null && response.users.runtimeType == String) {
      return response.users;
    }
    if (response.users != null) {
      return response.users.toString();
    }
    return '';
  }
}
