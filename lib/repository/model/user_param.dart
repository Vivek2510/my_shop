class MDLUserParam {
  int? userType;
  String? countryCode;
  String? mobileNumber;
  String? password;
  String? deviceType;
  String? deviceToken;
  String? appVersion;

  MDLUserParam(
      {this.userType,
      this.countryCode,
      this.password,
      this.mobileNumber,
      this.deviceToken,
      this.deviceType,
      this.appVersion});

  Map<String, dynamic> get toJson {
    return {
      'user_type': userType,
      'country_code': countryCode,
      'mobile_number': mobileNumber,
      'password': password,
      'device_type': deviceType,
      'device_token': deviceToken,
      'app_version': appVersion
    };
  }
}
