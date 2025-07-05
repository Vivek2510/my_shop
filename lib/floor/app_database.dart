import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../constant/import.dart';
import 'dao/user_dao.dart';

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [MDLUser])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
}
