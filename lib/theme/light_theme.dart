import 'package:flutter/material.dart';
import 'theme_colors.dart';
import 'base_theme.dart';

class AppLightTheme extends BaseTheme {
  static final AppLightTheme _instance = AppLightTheme._();

  AppLightTheme._();

  factory AppLightTheme() => _instance;

  @override
  Color get primaryColor => LightThemeColors.orange;

  @override
  Color get accentColor => LightThemeColors.black;

  @override
  Brightness get brightness => Brightness.light;

  @override
  ThemeData get lightTheme {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      brightness: brightness,
      scaffoldBackgroundColor: LightThemeColors.white,
      canvasColor: LightThemeColors.black,
      shadowColor: LightThemeColors.lightGrey,
      primaryColor: LightThemeColors.darkGrey,
      // primaryColorDark: LightThemeColors.backgroundRank,
      // buttonColor: LightThemeColors.getStartedCurveColor,
      // hintColor: LightThemeColors.hintTextColor,
      // focusColor: LightThemeColors.textFieldFillColor,
    );
  }

  @override
  Color? get darkAccentColor => null;

  @override
  Color? get darkPrimaryColor => null;

  @override
  ThemeData? get darkTheme => null;

  /// This will use for custom colors which couldn't part of the theme data.
  @override
  Map<String, Color> get customColor => {
    AppColors.white: LightThemeColors.white,
    AppColors.black: LightThemeColors.black,
    AppColors.grey: LightThemeColors.grey,
    AppColors.darkGrey: LightThemeColors.darkGrey,
    AppColors.lightGrey: LightThemeColors.lightGrey,
    AppColors.orange: LightThemeColors.orange,
    AppColors.green: LightThemeColors.green,
    AppColors.cardBackground: LightThemeColors.cardBackground,
    AppColors.placeholderBackground: LightThemeColors.placeholderBackground,
  };
}
