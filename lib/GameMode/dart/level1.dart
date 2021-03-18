import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paint_app/DrawingTools/dart/drawingInterface.dart';
import 'package:paint_app/DrawingTools/dart/paintFunctions.dart';
import 'package:paint_app/DrawingTools/dart/toolkit.dart';

class Level1 extends StatefulWidget {
  @override
  _Level1State createState() => _Level1State();
}

class _Level1State extends State<Level1> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<PaintedPoints> pointsList = List();

  List<PaintedSquares> squaresList = List();
  PaintedSquares squarePoint;

  List<PaintedCircles> circleList = List();
  PaintedCircles circlePoint;

  List<RecordPaints> paintedPoints = List();
  List<paintTools> toolUsageHistory = List();

  paintTools selectedTool = paintTools.brush;
  bool saveClicked = false;


  StrokeCap strokeType = StrokeCap.round;
  double selectedStrokeWidth = 3.0;

  Color selectedColor = Colors.black;

  void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
    );
  }

  void updatePoints(List<PaintedPoints> newPointsList, List<PaintedSquares> newSquaresList, PaintedSquares newSquarePoint,
      List<PaintedCircles> newCircleList, PaintedCircles newCirclePoint, List<RecordPaints> newPaintedPoints, List<paintTools> newToolUsageHistory) {
    setState(() {
      pointsList = newPointsList;
      squaresList = newSquaresList;
      squarePoint = newSquarePoint;
      circleList = newCircleList;
      circlePoint = newCirclePoint;
      paintedPoints = newPaintedPoints;
      toolUsageHistory = newToolUsageHistory;
    });
  }

  void changeBrushColor(Color color) {
    showToastMessage("Color updated");
    setState(() {
      selectedColor = color;
    });
  }

  void changeStrokeWidth(double strokeWidth) {
    showToastMessage("Stroke width updated");
    setState(() {
      selectedStrokeWidth = strokeWidth;
    });
  }

  void changeShape(String shape) {
    if(shape == "circle") showToastMessage("Selected Circle");
    else if(shape == "square") showToastMessage("Selected Square");

    setState(() {
      if(shape == "circle") selectedTool = paintTools.circle;
      else if(shape == "square") selectedTool = paintTools.square;
    });
  }

  void toggleSaveClicked() {
    showToastMessage("Image Captured");
    setState(() {
      saveClicked = !saveClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ToolBox(selectedStrokeWidth, changeStrokeWidth, selectedColor, changeBrushColor, selectedTool, changeShape),
              Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                child: FlatButton(
                  onPressed: () {
                    showToastMessage("All clear!");
                    setState(() {
                      pointsList.clear();
                      paintedPoints.clear();
                      squaresList.clear();
                      circleList.clear();
                    });
                  },
                  child: Text(
                      "Reset",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.redAccent,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                child: FlatButton(
                  onPressed: () {
                    showToastMessage("Progress saved!");
                    setState(() {

                    });
                  },
                  child: Text(
                    "Save Progress",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.amber,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      pointsList.clear();
                      paintedPoints.clear();
                      squaresList.clear();
                      circleList.clear();
                    });
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                child: DrawingInterface(
                    pointsList,
                    squaresList,
                    squarePoint,
                    circleList,
                    circlePoint,
                    paintedPoints,
                    toolUsageHistory,
                    selectedTool,
                    saveClicked,
                    strokeType,
                    selectedStrokeWidth,
                    selectedColor,
                    updatePoints,
                    toggleSaveClicked,
                ),
              )
            ),
            Positioned(
              left: 10,
              top: 30,
              child: OutlineButton(
                onPressed: () => _scaffoldKey.currentState.openDrawer(),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.settings,
                      size: 30.0,
                      color: Colors.blueGrey,
                    ),
                    Text(
                      " Tools",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                borderSide: BorderSide(
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 30,
              child: OutlineButton(
                onPressed: () {
                  print('Help');
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.help_outline,
                      size: 30.0,
                      color: Colors.blueGrey,
                    ),
                    Text(
                      " Help",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                borderSide: BorderSide(
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            Positioned(
              right: -10,
              top: 100,
              child: OutlineButton(
                onPressed: () {
                  showToastMessage("Selected Brush");
                  setState(() {
                    selectedTool = paintTools.brush;
                  });
                },
                child: Icon(Icons.brush),
                borderSide: BorderSide(
                  width: selectedTool == paintTools.brush ? 5 : 1,
                  style: BorderStyle.solid,
                  color: selectedTool == paintTools.brush ? Colors.blue : Colors.black,
                ),
                shape: CircleBorder(),
              ),
            ),
            Positioned(
              right: -10,
              top: 170,
              child: OutlineButton(
                onPressed: () {
                  showToastMessage("Selected Eraser");
                  setState(() {
                    selectedTool = paintTools.eraser;
                  });
                },
                child: Icon(Icons.crop_square),
                borderSide: BorderSide(
                  width: selectedTool == paintTools.eraser ? 5 : 1,
                  style: BorderStyle.solid,
                  color: selectedTool == paintTools.eraser ? Colors.blue : Colors.black,
                ),
                shape: CircleBorder(),
              ),
            ),
            Positioned(
              right: -10,
              top: 240,
              child: OutlineButton(
                onPressed: () {
                  showToastMessage("Undo Done");
                  setState(() {
                    if (toolUsageHistory.length > 0) {
                      paintTools lastAction = toolUsageHistory.last;
                      if (lastAction == paintTools.eraser ||
                          lastAction == paintTools.brush) {
                        if (paintedPoints.length > 0) {
                          RecordPaints lastPoint = paintedPoints.last;

                          if (lastPoint.endIndex != null)
                            pointsList.removeRange(
                                lastPoint.startIndex, lastPoint.endIndex);
                          paintedPoints.removeLast();
                        }
                      } else if (lastAction == paintTools.square) {
                        squaresList.removeLast();
                      } else {
                        circleList.removeLast();
                      }
                      toolUsageHistory.removeLast();
                    }
                  });
                },
                child: Icon(Icons.undo),
                borderSide: BorderSide(
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
                shape: CircleBorder(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: Icon(Icons.exit_to_app),
      ),
    );
  }
}
