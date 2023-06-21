
import 'dart:io';

import 'package:sqflite/sqflite.dart';

import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = 'mydatabase.db';
  static final _databaseVersion = 1;
  static final _tableName = 'mytable';
  static final columnId = '_id';
  static final columnText = 'text';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $_tableName (
            $columnId INTEGER PRIMARY KEY,
            $columnText TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(String text) async {
    Database db = await instance.database;
    return await db.insert(_tableName, {columnText: text});
  }

   Future<List<Map<String, dynamic>>> getAllData() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future<int> deleteData(int id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
  }



}