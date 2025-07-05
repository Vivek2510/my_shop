// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MDLUser` (`userId` TEXT, `authToken` TEXT, `searchKey` TEXT, PRIMARY KEY (`userId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _mDLUserInsertionAdapter = InsertionAdapter(
            database,
            'MDLUser',
            (MDLUser item) => <String, Object?>{
                  'userId': item.userId,
                  'authToken': item.authToken,
                  'searchKey': item.searchKey
                },
            changeListener),
        _mDLUserUpdateAdapter = UpdateAdapter(
            database,
            'MDLUser',
            ['userId'],
            (MDLUser item) => <String, Object?>{
                  'userId': item.userId,
                  'authToken': item.authToken,
                  'searchKey': item.searchKey
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MDLUser> _mDLUserInsertionAdapter;

  final UpdateAdapter<MDLUser> _mDLUserUpdateAdapter;

  @override
  Future<List<MDLUser>> findAllUsers() async {
    return _queryAdapter.queryList('SELECT * FROM MDLUser',
        mapper: (Map<String, Object?> row) => MDLUser(
            userId: row['userId'] as String?,
            searchKey: row['searchKey'] as String?,
            authToken: row['authToken'] as String?));
  }

  @override
  Stream<MDLUser?> findPersonById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Person WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MDLUser(
            userId: row['userId'] as String?,
            searchKey: row['searchKey'] as String?,
            authToken: row['authToken'] as String?),
        arguments: [id],
        queryableName: 'Person',
        isView: false);
  }

  @override
  Future<void> delete() async {
    await _queryAdapter.queryNoReturn('DELETE FROM MDLUser');
  }

  @override
  Future<void> updateNotificationFlag(int notificationFlag) async {
    await _queryAdapter.queryNoReturn('UPDATE MDLUser SET notification = ?1',
        arguments: [notificationFlag]);
  }

  @override
  Future<void> insertUser(MDLUser user) async {
    await _mDLUserInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUser(MDLUser user) async {
    await _mDLUserUpdateAdapter.update(user, OnConflictStrategy.abort);
  }
}
