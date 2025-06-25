import 'dart:io';

import 'package:grocery_app/Services/model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class Dbhelper {
  Database? db;

  Dbhelper._();
  static Dbhelper instance = Dbhelper._();
  
  //fields to be used for table name and columns
  static String TableName = 'GroceryTable';
  static String idColumn = 'id';
  static String groceryColumn = 'grocery';

  Future<Database> getDB() async{
    final db = await initDB();
    return db ?? db;
  }

  Future<Database> initDB() async{
    Directory directory =await getApplicationDocumentsDirectory();
    final path = join(directory.path,'grocery.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
      CREATE TABLE $TableName(
      $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
      $groceryColumn TEXT NOT NULL)
      ''');
      },);
  }

  Future<int> insertData(GroceryModel model) async{
    final dd = await getDB();
    return dd.insert(TableName, model.toMap());
  }

  Future<int> updateData(GroceryModel model) async{
    final dd = await getDB();
    return dd.update(TableName, model.toMap(),where: 'id = ?', whereArgs: [model.id]);
  }

  Future<int> deleteData(GroceryModel model) async{
    final dd = await getDB();
    return dd.delete(TableName,where: 'id = ?',whereArgs: [model.id]);
  }

  Future<List<GroceryModel>> getData() async{
    final dd = await getDB();
    List<Map<String,dynamic>> data = await dd.query(TableName);
    return data.map((c)=>GroceryModel.fromMap(c)).toList();
  }
}