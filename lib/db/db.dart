import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabase {
  static final _dbName = 'dailyTracker.db';
  static final _dbVersion = 1;
  static final tableName = {
    "userProfile": "userProfile",
    "userLocation": "userLocation",
  };

  UserDatabase._databaseConstructor();

  static final UserDatabase instance = UserDatabase._databaseConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initiateDatabase();

    return _database!;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE ${tableName["userProfile"]}(email TEXT PRIMARY KEY, firstName TEXT, lastName TEXT, password TEXT)      
      ''');

    await db.execute('''
    CREATE TABLE ${tableName["userLocation"]}(email TEXT PRIMARY KEY, latitude TEXT, longitude TEXT, address TEXT)      
      ''');
  }

  Future insert(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    print(row);
    if (table != 'userProfile') {
      bool search = await searchQuery(table, row['email']);
      if (search) {
        return await update(table, row);
      }
    }

    print(table);
    print(row);
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> select(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> selectByEmail(
      String table, String email) async {
    Database db = await instance.database;
    return await db.query(table, where: 'email = ?', whereArgs: [email]);
  }

  Future<int> update(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    String email = row['email'];
    return await db.update(table, row, where: 'email = ?', whereArgs: [email]);
  }

  Future<bool> searchQuery(
    String table,
    String email,
  ) async {
    Database db = await instance.database;
    List emailList =
        await db.query(table, where: 'email = ?', whereArgs: [email]);
    if (emailList.length > 0) {
      return true;
    } else {
      return false;
    }
  }
}
