import 'package:flutter/material.dart';
import 'theme_colors.dart';
import 'base_theme.dart';

class AppDarkTheme extends BaseTheme {
  static final AppDarkTheme _instance = AppDarkTheme._();

  AppDarkTheme._();

  factory AppDarkTheme() => _instance;

  @override
  Color get primaryColor => LightThemeColors.orange;

  @override
  Color get accentColor => LightThemeColors.black;

  @override
  Brightness get brightness => Brightness.dark;

  @override
  ThemeData get darkTheme {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      brightness: brightness,
      scaffoldBackgroundColor: DarkThemeColors.black,
      canvasColor: DarkThemeColors.black,
      shadowColor: DarkThemeColors.lightGrey,
      primaryColor: DarkThemeColors.darkGrey,
      // primaryColor: DarkThemeColors.primaryColor,
      // primaryColorDark: DarkThemeColors.primaryColorDark,
      // buttonColor: DarkThemeColors.getStartedCurveColor,
      // hintColor: DarkThemeColors.hintTextColor,
      // focusColor: DarkThemeColors.textFieldFillColor,
    );
  }

  @override
  Color? get darkAccentColor => null;

  @override
  Color? get darkPrimaryColor => null;

  @override
  ThemeData? get lightTheme => null;

  /// This will use for custom colors which couldn't part of the theme data.
  @override
  Map<String, Color> get customColor => {
    AppColors.white: DarkThemeColors.black,
    AppColors.black: DarkThemeColors.white,
    AppColors.grey: DarkThemeColors.grey,
    AppColors.darkGrey: DarkThemeColors.darkGrey,
    AppColors.lightGrey: DarkThemeColors.lightGrey,
    AppColors.orange: DarkThemeColors.orange,
    AppColors.green: DarkThemeColors.green,
    AppColors.cardBackground: DarkThemeColors.cardBackground,
    AppColors.placeholderBackground: DarkThemeColors.placeholderBackground,
  };
}
