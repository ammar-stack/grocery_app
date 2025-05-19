
import 'dart:io';

import 'package:grocery_app/grocerymodel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Dbhelper {
  
  Dbhelper._privateconstructor();

  static Dbhelper instance = Dbhelper._privateconstructor();

  Database? db;  
  
  //all fields
  static String tableName = 'groceryTable';
  static String idColumn = 'id';
  static String nameColumn = 'name';

  Future<Database> getDB() async{
    if(db != null){
      return db!;
    }
    else{
      db = await initDB();
      return db!;
    }
  }

  Future<Database> initDB() async{
    Directory directory =await getApplicationDocumentsDirectory();
    
    final path = join(directory.path,'grocery.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
            CREATE TABLE $tableName(
            $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
            $nameColumn TEXT)
        ''');
      },);
  }

  //inserting grocery name
  Future<int> insertName(GroceryModel model) async{
    final db = await getDB();
    return db.insert(tableName, model.toMap());
  }

  //getting names
  Future<List<GroceryModel>> getName() async{
    final db = await getDB();
    final List<Map<String,dynamic>> data = await db.query(tableName);

    return data.map((e) => GroceryModel.fromMap(e)).toList();
  }

  //updating name of a grocery
  Future<int> updateName(GroceryModel model) async{
    final db = await getDB();
    return await db.update(tableName, model.toMap(),where: 'id = ?',whereArgs: [model.id]);
  }

  //deleting a name
  Future<int> deleteName(int id) async{
    final db = await getDB();
    return db.delete(tableName,where: 'id = ?',whereArgs: [id]);
  }

}