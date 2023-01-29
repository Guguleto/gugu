
import 'dart:async';
import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../model/Phone.dart';

class DBHelper{
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return null;
  }

  initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cart.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cart(id INTEGER PRIMARY KEY,productId VARCHAR UNIQUE, title TEXT, price INTEGER, quantity INTEGER, description TEXT, image TEXT)');
  }

  Future<Phone> insert(Phone phone) async {
    var dbClient = await database;
    await dbClient!.insert('phone', phone.toJson());
    return phone;
  }

  Future<List<Phone>> getPhonesList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult =
    await dbClient!.query('phone');
    return queryResult.map((result) => Phone. fromJson(result)).toList();
  }

  Future<int> updateQuantity(Phone phone) async {
    var dbClient = await database;
    return await dbClient!.update('phone', phone.toJson(),
        where: "productId = ?", whereArgs: [phone.id]);
  }

  Future<int> deleteCartItem(int id) async {
    var dbClient = await database;
    return await dbClient!.delete('phone', where: 'id = ?', whereArgs: [id]);
  }
}