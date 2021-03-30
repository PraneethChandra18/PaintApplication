import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:paint_app/DrawingTools/dart/paintFunctions.dart';
import 'package:paint_app/DrawingTools/dart/toolkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class DrawingInterface extends StatefulWidget {

  final pointsList;
  final squaresList;
  final squarePoint;
  final circleList;
  final circlePoint;
  final paintedPoints;
  final toolUsageHistory;
  final selectedTool;
  final saveClicked;
  final captureImage;
  final evaluate;
  final strokeType;
  final strokeWidth;
  final selectedColor;
  final updatePoints;
  final toggleCaptureImageClicked;
  final changeEvaluationScore;
  final finalImage;

  DrawingInterface(
      this.pointsList,
      this.squaresList,
      this.squarePoint,
      this.circleList,
      this.circlePoint,
      this.paintedPoints,
      this.toolUsageHistory,
      this.selectedTool,
      this.saveClicked,
      this.captureImage,
      this.evaluate,
      this.strokeType,
      this.strokeWidth,
      this.selectedColor,
      this.updatePoints,
      this.toggleCaptureImageClicked,
      this.changeEvaluationScore,
      this.finalImage,
      );

  @override
  _DrawingInterfaceState createState() => _DrawingInterfaceState();
}

class _DrawingInterfaceState extends State<DrawingInterface> {

  List<PaintedPoints> pointsList;

  List<PaintedSquares> squaresList;
  PaintedSquares squarePoint;

  List<PaintedCircles> circleList;
  PaintedCircles circlePoint;

  List<RecordPaints> paintedPoints;
  List<paintTools> toolUsageHistory;

  paintTools selectedTool;
  bool isCanvasLocked = false;
  bool saveClicked;
  bool captureImage;
  bool evaluate;

  StrokeCap strokeType;
  double strokeWidth;
  Color selectedColor;

  int counter = 0;

  Paint getPoint() {
    if (selectedTool == paintTools.eraser) {
      return Paint()
        ..strokeCap = strokeType
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth
        ..color = Colors.white;
    } else {
      return Paint()
        ..strokeCap = strokeType
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth
        ..color = selectedColor;
    }
  }

  @override
  void initState() {
    pointsList = widget.pointsList;
    squaresList = widget.squaresList;
    squarePoint = widget.squarePoint;
    circleList = widget.circleList;
    circlePoint = widget.circlePoint;
    paintedPoints = widget.paintedPoints;
    toolUsageHistory = widget.toolUsageHistory;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    selectedTool = widget.selectedTool;
    saveClicked = widget.saveClicked;
    captureImage = widget.captureImage;
    evaluate = widget.evaluate;
    strokeType = widget.strokeType;
    strokeWidth = widget.strokeWidth;
    selectedColor = widget.selectedColor;

    return Container(
      child: LayoutBuilder(builder: (context, constraints) {
              return Container(
                width: constraints.widthConstraints().maxWidth,
                height: constraints.heightConstraints().maxHeight,
                color: Colors.black.withOpacity(0.7),
                child: GestureDetector(
                  onPanUpdate: (details) {
                    if (isCanvasLocked) return;
                    setState(() {
                      RenderBox renderBox =
                      context.findRenderObject();
                      if (selectedTool == paintTools.brush ||
                          selectedTool == paintTools.eraser) {
                        pointsList.add(
                          PaintedPoints(
                            points: renderBox.globalToLocal(
                                details.globalPosition),
                            paint: getPoint(),
                          ),
                        );
                      } else if (selectedTool ==
                          paintTools.square) {
                        squarePoint.end = renderBox
                            .globalToLocal(details.globalPosition);
                      } else if (selectedTool ==
                          paintTools.circle) {
                        circlePoint.end = renderBox
                            .globalToLocal(details.globalPosition);
                      }
                    });
                  },
                  onPanStart: (details) {
                    if (isCanvasLocked) return;
                    setState(() {
                      RenderBox renderBox =
                      context.findRenderObject();
                      if (selectedTool == paintTools.brush ||
                          selectedTool == paintTools.eraser) {
                        if (pointsList.length > 0) {
                          paintedPoints.add(
                              RecordPaints(pointsList.length, null));
                        } else
                          paintedPoints.add(RecordPaints(0, null));

                        pointsList.add(
                          PaintedPoints(
                            points: renderBox.globalToLocal(
                                details.globalPosition),
                            paint: getPoint(),
                          ),
                        );
                      } else if (selectedTool ==
                          paintTools.square) {
                        squarePoint = PaintedSquares();
                        Offset os = renderBox
                            .globalToLocal(details.globalPosition);
                        squarePoint.start = os;
                        squarePoint.end = os;
                        squarePoint.paint = getPoint();
                      } else if (selectedTool ==
                          paintTools.circle) {
                        circlePoint = PaintedCircles();
                        Offset os = renderBox
                            .globalToLocal(details.globalPosition);
                        circlePoint.start = os;
                        circlePoint.end = os;
                        circlePoint.paint = getPoint();
                      }
                    });
                  },
                  onPanEnd: (details) {
                    if (isCanvasLocked) return;

                    toolUsageHistory.add(selectedTool);
                    if (selectedTool == paintTools.brush ||
                        selectedTool == paintTools.eraser) {
                      paintedPoints
                          .firstWhere(
                              (element) => element.endIndex == null)
                          .endIndex = pointsList.length;
                      pointsList.add(null);
                    } else if (selectedTool ==
                        paintTools.square) {
                      setState(() {
                        squaresList.add(squarePoint);
                        squarePoint = null;
                      });
                    } else if (selectedTool ==
                        paintTools.circle) {
                      setState(() {
                        circleList.add(circlePoint);
                        circlePoint = null;
                      });
                    }
                    widget.updatePoints(pointsList,squaresList,squarePoint,circleList,circlePoint,paintedPoints,toolUsageHistory);
                  },
                  child: ClipRect(
                    child: Container(
                      //Canvas
                      color: Colors.white,
                      //margin: EdgeInsets.only(bottom: 50, right: 80),
                      child: CustomPaint(
                        size: Size(
                            constraints.widthConstraints().maxWidth,
                            constraints
                                .heightConstraints()
                                .maxHeight),
                        painter: PainterCanvas(
                          pointsList: pointsList,
                          squaresList: squaresList,
                          circlesList: circleList,
                          unfinishedSquare: squarePoint,
                          unfinishedCircle: circlePoint,
                          saveImage: saveClicked,
                          saveCallback: (Picture picture) async {
                            final img = await picture.toImage(constraints.maxWidth.round(),constraints.maxHeight.round());
                            var bytes = await img.toByteData(format: ImageByteFormat.png);
                            var byteList = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

                            if(captureImage) {
                              final directory = await getExternalStorageDirectory();
                              final imagePath = '${directory.path}/images_${DateTime.now()}.png' ;

                              await File(imagePath).writeAsBytes(byteList);
                              widget.toggleCaptureImageClicked();
                            }

                            if(evaluate) {

                              ByteData bytes2 = await rootBundle.load(widget.finalImage);
                              final byteList2 = bytes2.buffer.asUint8List(bytes2.offsetInBytes, bytes2.lengthInBytes);

                              double result = evaluateDrawing(byteList, byteList2);
                              widget.changeEvaluationScore(result);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          ),
    );
  }
}
