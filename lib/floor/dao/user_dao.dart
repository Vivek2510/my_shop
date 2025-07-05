import 'package:floor/floor.dart';
import '../../../constant/import.dart';

@dao
abstract class UserDao {

  @Query('SELECT * FROM MDLUser')
  Future<List<MDLUser>> findAllUsers();

  @Query('SELECT * FROM Person WHERE id = :id')
  Stream<MDLUser?> findPersonById(int id);

  @insert
  Future<void> insertUser(MDLUser user);

  @Update()
  Future<void> updateUser(MDLUser user);

  @Query('DELETE FROM MDLUser')
  Future<void> delete();

  @Query('UPDATE MDLUser SET notification = :notificationFlag')
  Future<void> updateNotificationFlag(int notificationFlag);
}