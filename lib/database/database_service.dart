import 'dart:io';

import 'package:mmreactiveform/database/database_config.dart';
import 'package:mmreactiveform/database/database_tables.dart';
import 'package:mmreactiveform/models/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';

class DatabaseService {
  // creating the private constructor(act like singleton)
  static final DatabaseService instance = DatabaseService._init();
  DatabaseService._init();
  static Database? _database;
  static late BriteDatabase _streamDatabase;
  static var lock = Lock();

  Future<Database?> get database async {
    if (_database != null) return _database;
    await lock.synchronized(() async {
      _database = await _initDatabase();
      _streamDatabase = BriteDatabase(_database!);
    });
    return _database;
  }

  // initializing the database
  _initDatabase() async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, DatabaseConfig.databaseName);
    Sqflite.setDebugModeOn(true);
    return await openDatabase(path,
        version: DatabaseConfig.databaseVersion, onCreate: _onCreate);
  }

  // creating the talble
  Future _onCreate(Database db, int version) async {
    await db.execute(DataBaseTable.tableProfile);
  }

  Future<BriteDatabase> get streamDatabase async {
// 2
    await database;
    return _streamDatabase;
  }

  // closign the database connection
  Future close() async {
    final db = await instance.database;
    db!.close();
  }

  // get the path of database
  Future<String?> getPath() async {
    String? path = await getDatabasesPath();
    return path;
  }

  // insert the data into correspondent table
  void insertProfile(String table, Map<String, dynamic> data) async {
    Database? db = await instance.streamDatabase;
    Batch batch = db.batch();
    batch.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await batch.commit(noResult: true);
  }

  // get the single user
  Future<List<Map<String, Object?>>> getSingleUserProfile(
      int created_date, String table) async {
    Database? db = await instance.database;
    final data = await db!.query(table,
        where: "created_date = ?", whereArgs: [created_date], limit: 1);
    return data;
  }

  // update the user profile
  void updateProfile(String table, Map<String, dynamic> data) async {
    Database? db = await instance.database;
    // do the update and get the number of affected rows
    int updateCount = await db!.update(table, data,
        where: 'created_date = ?', whereArgs: [data['created_date']]);
  }

  // retrive the all profiles
  Future<List<Map>> getAllProfiles() async {
    final db = await instance.streamDatabase;
    // final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('profile', orderBy: 'created_date DESC');
    return maps;
  }

  // stream of profiels
  Stream<List<Map>> watchAllProfiles() async* {
    final db = await instance.streamDatabase;
// 1
    yield* db.createQuery('profile').mapToList((row) => row);
  }

  // delete the whole database
  Future<bool> deleteDb() async {
    bool databaseDeleted = false;
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, DatabaseConfig.databaseName);
      await deleteDatabase(path).whenComplete(() {
        databaseDeleted = true;
      }).catchError((onError) {
        databaseDeleted = false;
      });
    } on DatabaseException catch (error) {
      throw Exception(error.toString());
    } catch (error) {
      // print(error);
    }
    return databaseDeleted;
  }

  // search the

  Future<List<User>> getUserByName(String name) async {
    Database? db = await instance.database;
    List data = [];
    await db!.query('profile',
        where: 'first_name LIKE ?',
        whereArgs: ['%$name%']).then((value) => data = value);
    return data.toList().map((e) => User.fromJson(e)).toList();
  }
}
