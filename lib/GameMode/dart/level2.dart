import 'package:flutter/material.dart';
import 'package:paint_app/DrawingTools/dart/drawingInterface.dart';
import 'package:paint_app/DrawingTools/dart/paintFunctions.dart';
import 'package:paint_app/DrawingTools/dart/toolkit.dart';
import 'package:paint_app/utils/global.dart';
import 'package:paint_app/utils/supportingWidgets.dart';


class Level2 extends StatefulWidget {
  @override
  _Level2State createState() => _Level2State();
}

class _Level2State extends State<Level2> {

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
  bool evaluate = true;

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
      captureImage = !captureImage;
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
              Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                child: FlatButton(
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
                    captureImage,
                    evaluate,
                    strokeType,
                    selectedStrokeWidth,
                    selectedColor,
                    updatePoints,
                    toggleCaptureImageClicked,
                    changeEvaluationScore,
                    "assets/level2/level2_6.jpg",
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
                onPressed: () => showCarouselDialog(context,
                    [
                      ["Step 1", "assets/level2/level2_1.jpg"],
                      ["Step 2", "assets/level2/level2_2.jpg"],
                      ["Step 3", "assets/level2/level2_3.jpg"],
                      ["Step 4", "assets/level2/level2_4.jpg"],
                      ["Step 5", "assets/level2/level2_5.jpg"],
                      ["Final Image", "assets/level2/level2_6.jpg"],
                    ]
                ),
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
        onPressed: () async {
          int result = await exitDialog(context);
          if(result == 1) {
            showToastMessage("Progress saved!");
            Navigator.pop(context);
          }
          else if(result == 2) Navigator.pop(context);
        },
        child: Icon(Icons.exit_to_app),
      ),
    );
  }
}
