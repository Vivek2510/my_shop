import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_demo/common/util.dart';
import 'package:task_demo/singleton/login_user.dart';

import 'cubit/theme_module/provider/theme_cubit.dart';
import 'ui/app.dart';

void main() {
  return runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      /// To get the last decided theme.
      changeThemeCubit.onDecideThemeChange();

      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.white,
        ),
      ); // 1

      /// Register the DB providers and init the DB
      await LoginUser.instance.initializationDatabase();

      /// To retrieve the login detail from local DB
      await LoginUser.instance.retrieveLoggedInUserDetail();

      runApp(const App());
    },
    (Object error, StackTrace stack) {
      debugPrint(error.toString());
      hideLoader();
    },
  );
}
