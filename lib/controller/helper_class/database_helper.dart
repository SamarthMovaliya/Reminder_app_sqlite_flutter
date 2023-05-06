import 'package:flutter/material.dart';
import 'package:reminder_app/views/screens/reminder_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  DataBaseHelper._();

  static final DataBaseHelper dataBaseHelper = DataBaseHelper._();
  Database? db;
  String dbName = 'reminderApp12';
  String tableName = 'reminderTable1';
  String id = 'id';
  String title = 'title';
  String description = 'description';
  String color = 'color';
  String time = 'time';

  Future<void> initDB() async {
    String directoryPath = await getDatabasesPath();
    String path = join(directoryPath, dbName);

    db = await openDatabase(
      path,
      version: 2,
      onCreate: (Database db, int version) async {
        String query =
            'CREATE TABLE IF NOT EXISTS $tableName($id INTEGER PRIMARY KEY AUTOINCREMENT ,$title TEXT ,$description TEXT, $color TEXT, $time TEXT)';
        await db.execute(query);
        print('database Created');
      },
    );
  }

  Future insertData(
      {required String Title,
      required String Description,
      required String Color,
      required String Time}) async {
    await initDB();
    String query =
        'INSERT INTO $tableName($title,$description,$color,$time)VALUES(?,?,?,?)';
    List arguments = [
      Title,
      Description,
      Color,
      Time,
    ];
    int? id = await db?.rawInsert(query, arguments);
    print(id);
  }

  updateDatabase({
    required int id1,
    required String title1,
    required String description1,
    required String color1,
    required time1,
  }) async {
    String query =
        'UPDATE $tableName SET $title = ?, $description = ?,$time = ?,$color = ? WHERE $id = ?';
    List arguments = [
      title1,
      description1,
      time1,
      color1,
      id1,
    ];
    db!.rawUpdate(query, arguments);
  }

  fetchAllRecode() async {
    await initDB();
    String query = "SELECT * FROM $tableName";

    List<Map<String, dynamic>> data = await db!.rawQuery(query);
    print(data);
    List<reminderModel> allData =
        data.map((e) => reminderModel.fromMap(data: e)).toList();
    return allData;
  }

  deleteData({required int id}) async {
    await initDB();
    String query = 'DELETE FROM $tableName WHERE id = $id';
    db?.rawDelete(query);
  }

  dummy({required int id}) {
    print('hello ${id}');
  }
}
