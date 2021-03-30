import 'dart:io';
import 'package:paint_app/utils/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
    static DatabaseHelper _databaseHelper;
    static Database _database;

    String userInformationTable = "UserInformation";

    String colLevel = 'DifficultyLevel';
    String colScore = 'Score';

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
      Directory directory =  await getApplicationDocumentsDirectory();
      String path = directory.path + '/userInformation.db';

      var userInformationDatabase = await openDatabase(path, version: 1, onCreate: _createDb);

      return userInformationDatabase;
    }

    void _createDb(Database db, int newVersion) async {
      await db.execute('CREATE TABLE $userInformationTable($colLevel INTEGER PRIMARY KEY AUTOINCREMENT, $colScore INTEGER)');
    }

    Future<List<Map<String, dynamic>>> getUserInformationMapList() async {
      Database db = await this.database;

      var result = await db.query(userInformationTable);
      return result;
    }

    Future<int> insertUserInformation(UserInformation data) async {
      Database db = await this.database;
      var result = await db.insert(userInformationTable, data.toMap());
      return result;
    }

    Future<int> updateUserInformation(UserInformation data) async {
      var db = await this.database;
      var result = await db.update(userInformationTable, data.toMap(), where: '$colLevel = ?', whereArgs:  [data.difficultyLevel]);
      print("Updating...");
      return result;
    }

    Future<int> deleteUserInformation(int level) async {
      var db = await this.database;
      int result = await db.rawDelete('DELETE FROM $userInformationTable WHERE $colLevel = $level');
      return result;
    }

    Future<int> getCount() async {
      Database db = await this.database;
      List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $userInformationTable');
      int result = Sqflite.firstIntValue(x);
      return result;
    }

    Future<List<UserInformation>> getUserInformationList() async {

      var userInformationMapList = await getUserInformationMapList();
      int count = userInformationMapList.length;

      List<UserInformation> userInformationList = List<UserInformation>();

      for(int i=0;i<count;i++) {
        userInformationList.add(UserInformation.fromMapObject(userInformationMapList[i]));
      }

      return userInformationList;
    }
}


// class DatabaseHelper {
//
//   static DatabaseHelper _databaseHelper;
//   static Database _database;
//
//   String savedDrawingsTable = 'SavedDrawings';
//   String colId = 'id';
//   String colName = 'name';
//   String colFilePath = 'filePath';
//   String colPointsList = 'pointsList';
//   String colSquaresList = 'squaresList';
//   String colCirclesList = 'circlesList';
//   String colPaintedPoints = 'paintedPoints';
//   String colToolUsageHistory = 'toolUsageHistory';
//
//   DatabaseHelper._createInstance();
//
//   factory DatabaseHelper() {
//
//     if(_databaseHelper == null) {
//       _databaseHelper = DatabaseHelper._createInstance();
//     }
//     return _databaseHelper;
//   }
//
//   Future<Database> get database async {
//
//     if(_database == null) {
//       _database = await initializeDatabase();
//     }
//     return _database;
//   }
//
//   Future<Database> initializeDatabase() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     String path = directory.path + 'savedDrawings.db';
//
//     var savedDrawingsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
//     return savedDrawingsDatabase;
//   }
//
//   void _createDb(Database db, int newVersion) async {
//
//     await db.execute('CREATE TABLE $savedDrawingsTable($colName TEXT, $colFilePath TEXT, '
//         '$colPointsList TEXT, $colSquaresList TEXT, $colCirclesList TEXT, $colPaintedPoints TEXT, $colToolUsageHistory TEXT)');
//   }
//
//
//   Future<List<Map<String, dynamic>>> getSavedDrawingsMapList() async {
//     Database db = await this.database;
//
//     var result = await db.query(savedDrawingsTable);
//     return result;
//   }
//
//   Future<int> insertDrawing(SavedDrawings drawing) async {
//     Database db = await this.database;
//     var result = await db.insert(savedDrawingsTable, drawing.toMap());
//     return result;
//   }
//
//   Future<int> updateDrawing(SavedDrawings drawing) async {
//     var db = await this.database;
//     var result = await db.update(savedDrawingsTable, drawing.toMap(), where: '$colId = ?', whereArgs:  [drawing.id]);
//     return result;
//   }
//
//   Future<int> deleteNode(int id) async {
//     var db = await this.database;
//     int result = await db.rawDelete('DELETE FROM $savedDrawingsTable WHERE $colId = $id');
//     return result;
//   }
//
//   Future<int> getCount() async {
//     Database db = await this.database;
//     List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $savedDrawingsTable');
//     int result = Sqflite.firstIntValue(x);
//     return result;
//   }
// }