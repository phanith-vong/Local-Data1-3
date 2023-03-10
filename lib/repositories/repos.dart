// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/people_model.dart';
import '../services/connection_db.dart';

class Repository {
  late ConnectionDb _connectionDb;
  Repository() {
    _connectionDb = ConnectionDb();
  }
  static Database? _database;
  Future<Database?> get database async {
    // Restart Database ==================================
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // String path = join(documentsDirectory.path, 'db_name');
    // await deleteDatabase(path);
    // print('Database Restarted');
    //==========================

    if (_database != null) {
      return _database;
    }
    _database = await _connectionDb.setDatabase();
    return _database;
  }

  insertPeople(table, PeopleModel data) async {
    var con = await database;
    return await con!.rawInsert(
      'INSERT INTO tbPeople(name, gender,address,photo) VALUES(?, ?, ?, ?)',
      [data.name, data.gender, data.address, data.photo],
    );
  }

  selectPeople(table) async {
    var con = await database;
    return await con!.query(table);
  }

  deletePeople(table, id) async {
    var con = await database;
    return await con!.delete(table, where: "id = ?", whereArgs: [id]);
  }

  updatePeople(table, data, id) async {
    var con = await database;
    return await con!.update(table, data, where: "id= ?", whereArgs: [id]);
  }
}
