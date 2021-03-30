import 'package:paint_app/DrawingTools/dart/paintFunctions.dart';

class UserInformation {

  int _difficultyLevel;
  int _score;

  UserInformation(this._score);
  UserInformation.withLevel(this._difficultyLevel, this._score);

  int get difficultyLevel => _difficultyLevel;

  int get score => _score;

  set score(int newScore) {
    this._score = newScore;
  }

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic> ();

    if(difficultyLevel!=null) {
      map['difficultyLevel'] = _difficultyLevel;
    }
    map['score'] = _score;

    return map;
  }

  UserInformation.fromMapObject(Map<String, dynamic> map) {
    this._difficultyLevel = map['DifficultyLevel'];
    this._score = map['Score'];
  }
}

class SavedDrawings {

  int id;
  String name;
  String filePath;
  List<PaintedPoints> pointsList;
  List<PaintedSquares> squaresList;
  List<PaintedCircles> circlesList;
  List<RecordPaints> paintedPoints;
  List<paintTools> toolUsageHistory;

  SavedDrawings({this.name, this.filePath, this.pointsList, this.squaresList, this.circlesList, this.paintedPoints, this.toolUsageHistory});

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic> ();

    map['id'] = id;
    map['name'] = name;
    map['filepath'] = filePath;
    map['pointsList'] = pointsList;
    map['squaresList'] = squaresList;
    map['circlesList'] = circlesList;
    map['paintedPoints'] = paintedPoints;
    map['toolUsageHistory'] = toolUsageHistory;

    return map;
  }

  SavedDrawings.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.filePath = map['filePath'];
    this.pointsList = map['pointsList'];
    this.squaresList = map['squaresList'];
    this.circlesList = map['circlesList'];
    this.paintedPoints = map['paintedPoints'];
    this.toolUsageHistory = map['toolUsageHistory'];
  }
}