import 'package:flutter/material.dart' show Locale;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_demo/singleton/login_user.dart';
import '../../constant/import.dart';

part 'language_state.dart';

LanguageCubit changeLanguageCubit = LanguageCubit()..onDecideLanguageChange();

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(SelectedLanguageState(Locale(LanguageType.en.name)));

  void toEnglish() {
    _saveOptionValue(0);
    emit(SelectedLanguageState(Locale(LanguageType.en.name)));
  }

  void toFrench() {
    _saveOptionValue(1);
    emit(SelectedLanguageState(Locale(LanguageType.fr.name)));
  }
  void toDutch() {
    _saveOptionValue(2);
    emit(SelectedLanguageState(Locale(LanguageType.nl.name)));
  }

  void onDecideLanguageChange() async {
    final optionValue = await getOption();
    print("Lang optionValue is $optionValue");
    if (optionValue == 0) {
      /// English Language
      toEnglish();
    } else if (optionValue == 1) {
      /// French Language
      toFrench();
    }
    else if (optionValue == 1) {
      /// Dutch Language
      toDutch();
    }
  }

  Future<void> _saveOptionValue(int optionValue) async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setInt('lang_option', optionValue);
    LoginUser.instance.didUpdateLanguageData.value = true;
  }

  Future<int> getOption() async {
    try {
      var preferences = await SharedPreferences.getInstance();
      int option = preferences.getInt('lang_option') ?? 0;
      return option;
    } catch (e) {
      return 1;
    }
  }

  Future<LanguageType> getLanguageType() async {
    var option = await getOption();
    return option == 0 ? LanguageType.en : option == 1 ? LanguageType.fr : LanguageType.nl;
  }
}
