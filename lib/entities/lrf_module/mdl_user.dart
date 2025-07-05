import 'package:floor/floor.dart';

@entity
class MDLUser {
  @primaryKey
  String? userId;
  String? authToken;
  String? searchKey;

  MDLUser({this.userId, this.searchKey, required this.authToken});

  MDLUser.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    searchKey = json['searchKey'];
    authToken = json['authToken'];
  }
}
