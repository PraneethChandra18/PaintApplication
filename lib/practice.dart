import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paint_app/DrawingTools/dart/drawingInterface.dart';
import 'package:paint_app/DrawingTools/dart/paintFunctions.dart';
import 'package:paint_app/DrawingTools/dart/toolkit.dart';
import 'package:paint_app/utils/supportingWidgets.dart';
import 'package:paint_app/utils/global.dart';

class Practice extends StatefulWidget {
  @override
  _PracticeState createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<PaintedPoints> pointsList = List();

  List<PaintedSquares> squaresList = List();
  PaintedSquares squarePoint;

  List<PaintedCircles> circleList = List();
  PaintedCircles circlePoint;

  List<RecordPaints> paintedPoints = List();
  List<paintTools> toolUsageHistory = List();

  paintTools selectedTool = paintTools.brush;


  StrokeCap strokeType = StrokeCap.round;
  double selectedStrokeWidth = 3.0;

  Color selectedColor = Colors.black;

  bool saveClicked = false;
  bool captureImage = false;
  bool evaluate = false;

  double evaluationScore = 0.0;

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

  void toggleCaptureImageClicked() {
    showToastMessage("Image Captured");
    setState(() {
      captureImage = false;
      saveClicked = !saveClicked;
    });
  }

  void changeEvaluationScore(double x) {
    print(x);
    setState(() {
      evaluationScore = x;
      saveClicked = !saveClicked;
      evaluate = false;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                    child: FlatButton(
                      onPressed: () async {

                        int result = await saveExistedDialog(context);
                        if(result == 1)
                        {
                          showToastMessage("Progress saved!");
                        }
                        else if(result == 2)
                        {
                          showToastMessage("Progress saved!");
                        }
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
                          saveClicked = true;
                          captureImage = true;
                        });
                      },
                      child: Text(
                        "Capture Photo",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.teal,
                    ),
                  ),
                ],
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
                    captureImage,
                    evaluate,
                    strokeType,
                    selectedStrokeWidth,
                    selectedColor,
                    updatePoints,
                    toggleCaptureImageClicked,
                    changeEvaluationScore,
                    "assets/level1/level1.jpg",
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
                    FaIcon(
                      FontAwesomeIcons.tools,
                      size: 20.0,
                      color: Colors.indigo[900],
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
                  color: selectedTool == paintTools.brush ? Colors.indigo[900] : Colors.black,
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
                  color: selectedTool == paintTools.eraser ? Colors.indigo[900] : Colors.black,
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
            Positioned(
              right: -10,
              top: 310,
              child: OutlineButton(
                onPressed: () async {
                  bool result = await confirmationDialog(context, "Reset");
                  if(result == true)
                  {
                    showToastMessage("All clear!");
                    setState(() {
                      pointsList.clear();
                      paintedPoints.clear();
                      squaresList.clear();
                      circleList.clear();
                    });
                  }
                },
                child: Icon(Icons.clear),
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
        onPressed: () async {
          int result = await exitDialog(context);
          if (result == 1) {
            int result = await saveExistedDialog(context);
            if (result == 1) {
              showToastMessage("Progress saved!");
              Navigator.pop(context);
            }
            else if (result == 2) {
              showToastMessage("Progress saved!");
              Navigator.pop(context);
            }
          }
          else if (result == 2) Navigator.pop(context);
        },
        child: Icon(Icons.exit_to_app),
      ),
    );
  }
}