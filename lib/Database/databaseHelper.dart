import 'dart:io';
import 'package:paint_app/utils/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;
  static Database _database;

  String savedDrawingsTable = 'SavedDrawings';
  String colId = 'id';
  String colName = 'name';
  String colFilePath = 'filePath';
  String colPointsList = 'pointsList';
  String colSquaresList = 'squaresList';
  String colCirclesList = 'circlesList';
  String colPaintedPoints = 'paintedPoints';
  String colToolUsageHistory = 'toolUsageHistory';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {

    if(_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if(_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'savedDrawings.db';

    var savedDrawingsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return savedDrawingsDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $savedDrawingsTable($colName TEXT, $colFilePath TEXT, '
        '$colPointsList TEXT, $colSquaresList TEXT, $colCirclesList TEXT, $colPaintedPoints TEXT, $colToolUsageHistory TEXT)');
  }


  Future<List<Map<String, dynamic>>> getSavedDrawingsMapList() async {
    Database db = await this.database;

    var result = await db.query(savedDrawingsTable);
    return result;
  }

  Future<int> insertDrawing(SavedDrawings drawing) async {
    Database db = await this.database;
    var result = await db.insert(savedDrawingsTable, drawing.toMap());
    return result;
  }

  Future<int> updateDrawing(SavedDrawings drawing) async {
    var db = await this.database;
    var result = await db.update(savedDrawingsTable, drawing.toMap(), where: '$colId = ?', whereArgs:  [drawing.id]);
    return result;
  }

  Future<int> deleteNode(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $savedDrawingsTable WHERE $colId = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $savedDrawingsTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
}