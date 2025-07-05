import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:task_demo/constant/device.dart';
import 'package:task_demo/route/pages.dart';
import 'package:task_demo/singleton/login_user.dart';
import '../constant/import.dart';
import '../cubit/language_module/language_cubit.dart';
import '../localization/app_localizations_setup.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  bool _hasVisibleNoInternet = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    Future.delayed(const Duration(seconds: 1)).then((value) {
      _configureInternetConnectivity();
    });
    _configureLanguageUpdateListener();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
    // providers: [
    //   BlocProvider<CartCubit>(
    //     create: (context) => CartCubit(
    //         repository: AppRepositoryBuilder.repository(
    //             of: RepositoryProviderType.cart)),
    //   ),
    // ],
    BlocConsumer<LanguageCubit, LanguageState>(
      bloc: changeLanguageCubit,
      listenWhen:
          (previousState, currentState) => previousState != currentState,
      listener: (previousState, currentState) {
        /// To update the selected local for language.
        Get.updateLocale(currentState.locale);
      },
      buildWhen: (previousState, currentState) => previousState != currentState,
      builder: (context, languageState) {
        return  ScreenUtilInit(
            designSize: Device.defaultSize,
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
            return OverlaySupport(
              child: GetMaterialApp(
                debugShowCheckedModeBanner: false,
                enableLog: false,
                navigatorKey: Get.key,
                initialRoute: _initMainScreen(),
                getPages: AppPages.routes,
                supportedLocales: AppLocalizationsSetup.supportedLocales,
                localizationsDelegates:
                    AppLocalizationsSetup.localizationsDelegates,
                localeResolutionCallback:
                    AppLocalizationsSetup.localeResolutionCallback,
                // Each time a new state emitted, the app will be rebuilt with the new locale.
                locale: languageState.locale,
                fallbackLocale: Locale(LanguageType.en.name),
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context),
                    child: child ?? Container(),
                  );
                },
              ),
            );
          }
        );
      },
    );
  }
  // Widget build(BuildContext context) {
  //   return OverlaySupport(
  //     child: GetMaterialApp(
  //       debugShowCheckedModeBanner: false,
  //       enableLog: false,
  //       navigatorKey: Get.key,
  //       initialRoute: _initMainScreen(),
  //       getPages: AppPages.routes,
  //     ),
  //   );
  // }

  String _initMainScreen() {
    // if (LoginUser.instance.isLoggedIn) {
    //   return Routes.tabBar;
    // } else {
    //   return Routes.intro;
    // }
    return Routes.homeScreen;
  }

  void _showNoInternetAlert(ConnectivityResult result) {
    if (result == ConnectivityResult.none && !_hasVisibleNoInternet) {
      _hasVisibleNoInternet = true;
      Get.generalDialog(
        barrierDismissible: false,
        barrierLabel: 'barrierLabel',
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 0),
        pageBuilder: (
          BuildContext buildContext,
          Animation animation,
          Animation secondaryAnimation,
        ) {
          return Text("Show InternetAlert");
          // return const WillPopScope(
          //   child: InternetAlert(),
          //   onWillPop: performWillPopTwoClick,
          // );
        },
      );
    } else if (_hasVisibleNoInternet) {
      Get.back();
      _hasVisibleNoInternet = false;
    }
  }

  void _configureInternetConnectivity() {
    /// To check the internet while launching the app.
    Connectivity().checkConnectivity().then((value) {
      print("internet = == = $value");
      if (value == ConnectivityResult.none) {
        _showNoInternetAlert(value.first);
      }
    });

    Connectivity().onConnectivityChanged.listen((event) {
      _showNoInternetAlert(event.first);
    });
  }

  void _configureLanguageUpdateListener() {
    LoginUser.instance.didUpdateLanguageData.listen((value) {
      print('app.Language data updated == = ');
    });
  }
}
