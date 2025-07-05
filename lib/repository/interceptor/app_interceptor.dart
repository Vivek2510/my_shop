import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../singleton/login_user.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    /// Set the Bearer token if user is loggedIn.
    options.headers.addAll({'authorization': 'Bearer ${LoginUser.instance.user?.authToken ?? ''}'});

    debugPrint(
        "##REQ: URL: ${options.baseUrl} END POINT: ${options.path}   DATA: ${options.data.toString()} QUERY DATA: ${options.queryParameters.toString()} Headers: ${options.headers.toString()}");

    super.onRequest(options, handler);
  }
}
