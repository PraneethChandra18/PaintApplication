import 'dart:io';

import 'package:flutter/material.dart';
import 'package:paint_app/myGallery.dart';
import 'package:paint_app/utils/supportingWidgets.dart';

//ignore: must_be_immutable
class GridItem extends StatefulWidget {
  final Key key;
  final FileSystemEntity item;
  final ValueChanged<bool> isSelected;
  var selectedValue;
  final allImages;
  final changeAllImages;

  GridItem({this.item, this.isSelected, this.key, this.selectedValue, this.allImages, this.changeAllImages});

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    isSelected = widget.selectedValue;
    return InkWell(
      onTap: () async {
        if(longPress == false) {
          int result = await showPhotoDialog(context, widget.item);
          if(result == 1) {
            widget.allImages.remove(widget.item);
            widget.changeAllImages(widget.allImages);
          }
        }
        else {
          setState(() {
            widget.selectedValue = !widget.selectedValue;
            widget.isSelected(widget.selectedValue);
          });
        }
      },
      onLongPress: () {
        longPress = true;
        setState(() {
          widget.selectedValue = !widget.selectedValue;
          widget.isSelected(widget.selectedValue);
        });
      },
      child: Stack(
        children: <Widget>[
          Image.file(
            widget.item,
            color: Colors.black.withOpacity(isSelected ? 0.9 : 0),
            colorBlendMode: BlendMode.color,
          ),
          isSelected
              ? Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.check_circle,
                color: Colors.blue,
              ),
            ),
          )
              : Container()
        ],
      ),
    );
  }
}