mixin ValidationMixin {
  bool isFieldEmpty(String fieldValue) => fieldValue.trim().isEmpty;

  bool validateCheckBox(bool checkbox) {
    if (checkbox == false) {
      return true;
    }
    return false;
  }

  bool validateEmailAddress(String email) {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(email.trim());
  }

  bool passwordValidation(String password) {
    if (password.length < 8 || password.contains(' ')) {
      return false;
    }
    return true;
  }

  bool confirmPasswordValidation(String password, String confirmPwd) {
    return (password != confirmPwd);
  }
}
