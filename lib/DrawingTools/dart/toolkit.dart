import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paint_app/DrawingTools/dart/paintFunctions.dart';
import 'package:paint_app/utils/global.dart';
import 'package:diff_image/diff_image.dart';
import 'package:image/image.dart' as Img;

double evaluateDrawing(Uint8List first, Uint8List second) {

  Img.Image firstImage = Img.decodeImage(first);
  Img.Image secondImage = Img.decodeImage(second);

  Img.Image fImage = Img.copyResize(firstImage, width: 500, height: 500);
  Img.Image sImage = Img.copyResize(secondImage, width: 500, height: 500);

  DiffImgResult diff = DiffImage.compareFromMemory(
    fImage,
    sImage,
    asPercentage: true,
    ignoreAlpha: true,
  );

  return diff.diffValue;
}


class ToolBox extends StatelessWidget {

  final selectedStrokeWidth;
  final changeStrokeWidth;
  final selectedColor;
  final changeBrushColor;
  final selectedTool;
  final changeShape;

  ToolBox(this.selectedStrokeWidth,this.changeStrokeWidth,this.selectedColor,this.changeBrushColor,this.selectedTool,this.changeShape);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
            child: Text(
              "Tool Box",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          SelectStrokeWidth(selectedStrokeWidth, changeStrokeWidth),
          PickColor(selectedColor, changeBrushColor),
          SelectShape(selectedTool, changeShape),
        ],
      ),
    );
  }
}

class PickColor extends StatefulWidget {

  final selectedColor;
  final changeBrushColor;

  PickColor(this.selectedColor, this.changeBrushColor);

  @override
  _PickColorState createState() => _PickColorState();
}

class _PickColorState extends State<PickColor> {

  Color pickedColor;

  @override
  void initState() {
    pickedColor = widget.selectedColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(5, 0, 0, 10),
              child: Text(
                "Pick Color",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            ColorPicker(
              pickerColor: pickedColor,
              onColorChanged: (color) {
                pickedColor = color;
              },
              pickerAreaHeightPercent: 0.5,
              enableAlpha: true,
              displayThumbColor: true,
              showLabel: true,
              paletteType: PaletteType.hsv,
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(0, 0, 5, 10),
              child: FlatButton(
                onPressed: () => widget.changeBrushColor(pickedColor),
                child: Text(
                  "Apply",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.indigo[900],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectStrokeWidth extends StatefulWidget {

  final selectedStrokeWidth;
  final changeStrokeWidth;

  SelectStrokeWidth(this.selectedStrokeWidth, this.changeStrokeWidth);

  @override
  _SelectStrokeWidthState createState() => _SelectStrokeWidthState();
}

class _SelectStrokeWidthState extends State<SelectStrokeWidth> {

  double strokeWidth;

  @override
  void initState() {
    strokeWidth = widget.selectedStrokeWidth;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(5, 0, 0, 10),
              child: Text(
                "Select stroke width",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            SliderTheme(
              data: SliderThemeData(
                // thumbColor: Colors.blue,
                // activeTrackColor: Colors.blue,
                // inactiveTrackColor: Colors.blue[100],
                // overlayColor: Colors.transparent,
              ),
              child: Slider(
                label: strokeWidth.abs().toString(),
                value: strokeWidth,
                max: 50.0,
                min: 1.0,
                divisions: 49,
                onChanged: (val) {
                  setState(() {
                    strokeWidth = val;
                  });
                }
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(0, 0, 5, 10),
              child: FlatButton(
                onPressed: () => widget.changeStrokeWidth(strokeWidth),
                child: Text(
                  "Apply",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.indigo[900],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectShape extends StatefulWidget {

  final tool;
  final changeShape;

  SelectShape(this.tool, this.changeShape);

  @override
  _SelectShapeState createState() => _SelectShapeState();
}

class _SelectShapeState extends State<SelectShape> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 10),
          child: Text(
            "Select shape",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            OutlineButton(
              onPressed: () => widget.changeShape("square"),
              child: Icon(Icons.crop_square),
              borderSide: BorderSide(
                width: widget.tool == paintTools.square ? 5 : 1,
                style: BorderStyle.solid,
                color: widget.tool == paintTools.square ? Colors.indigo[900] : Colors.black,
              ),
              shape: CircleBorder(),
            ),
            OutlineButton(
              onPressed: () => widget.changeShape("circle"),
              child: FaIcon(FontAwesomeIcons.circle),
              borderSide: BorderSide(
                width: widget.tool == paintTools.circle ? 5 : 1,
                style: BorderStyle.solid,
                color: widget.tool == paintTools.circle ? Colors.indigo[900] : Colors.black,
              ),
              shape: CircleBorder(),
            ),
          ],
        ),
      ],
    );
  }
}
