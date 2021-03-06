import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:paint_app/utils/global.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';


Future<dynamic> confirmationDialog(BuildContext context, String confirmationFor) async {
  return await showDialog(
  context: context,
  builder: (context) {
      return AlertDialog(
        title: Text('Confirmation'),
        content: Text('Do you want to $confirmationFor?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(false); // dismisses only the dialog and returns false
            },
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(true); // dismisses only the dialog and returns true
            },
            child: Text('Yes'),
          ),
        ],
      );
    },
  );
}

Future<dynamic> saveDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Confirmation'),
        content: Text('Do you want to overwrite the previously saved file?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(1); // dismisses only the dialog and returns false
            },
            child: Text('Overwrite'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(0); // dismisses only the dialog and returns true
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}

Future<dynamic> saveExistedDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Confirmation'),
        content: Text('Do you want to overwrite the previously saved file or save as a new file?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(1); // dismisses only the dialog and returns false
            },
            child: Text('Overwrite'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(2); // dismisses only the dialog and returns true
            },
            child: Text('New'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(0); // dismisses only the dialog and returns true
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}

Future<dynamic> exitDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Confirmation'),
        content: Text('Do you want to exit?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(1); // dismisses only the dialog and returns false
            },
            child: Text('Save and Exit'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(2); // dismisses only the dialog and returns true
            },
            child: Text('Do not save'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(0); // dismisses only the dialog and returns true
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}

showEvaluationScore(BuildContext context, String displayScore,int stars) {
  showDialog(
    context: context,
    builder: (context) {
      Size size = MediaQuery.of(context).size;
      return AlertDialog(
        title: Center(child: const Text('Evaluation Completed')),
        content: Container(
          height: size.height*0.4,
          width: size.width*0.5,
          child: Center(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 50,
                  left:45,
                  child: Icon(
                    Icons.star,
                    color: (stars==1 || stars ==2 || stars==3)?Colors.amber:Colors.grey,
                    size:50.0,
                  ),
                ),
                Positioned(
                  top: 0,
                  left:95,
                  child: Icon(
                    Icons.star,
                    color: (stars ==2 || stars==3)?Colors.amber:Colors.grey,
                    size:50.0,
                  ),
                ),
                Positioned(
                  top: 50,
                  left:145,
                  child: Icon(
                    Icons.star,
                    color: (stars==3)?Colors.amber:Colors.grey,
                    size:50.0,
                  ),
                ),
                Positioned(
                  top: 150,
                  left:0,
                  child: Text(
                    (stars<=1)?"Decent start for beginners\nTry to improve" : (stars<=2)? "Practice more to reach the pinnacle" : "Good job! Keep Drawing",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Positioned(
                  top: 250,
                  left:80,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    textColor: Theme.of(context).primaryColor,
                    child: const Text('CLOSE',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                  ),
                ),
              ],
            ),
          ),
        )
      );
    },
  );
}

Future<void> _shareImage(FileSystemEntity image) async {
  try {
    String str = image.toString().substring(7);
    str = str.substring(0, str.length - 1);
    await WcFlutterShare.share(sharePopupTitle: 'share',
        mimeType: 'image/png',
        fileName: 'image.png',
        bytesOfFile: File(str).readAsBytesSync());

  } catch (e) {
    print('error in sharing image : $e');
  }
}

Future<bool> deleteImage(BuildContext context, File file) async {
  bool result = await confirmationDialog(context, "Delete");
  if(result == true)
  {
    showToastMessage("Deleted!");
    if(await file.exists()){
      await file.delete();
    }
  }
  return result;
}

Future<dynamic> showPhotoDialog(BuildContext context, File photo) async {

  Size size = MediaQuery.of(context).size;

  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlatButton(
              color: Colors.transparent,
              onPressed: () async {
                await _shareImage(photo);
                Navigator.of(context, rootNavigator: true).pop(0);
              },
              child: Icon(
                Icons.share,
                color: Colors.white,
              ),
            ),
            FlatButton(
              color: Colors.transparent,
              onPressed: () async {
                bool result = await deleteImage(context, photo);
                if(result) Navigator.of(context, rootNavigator: true).pop(1);
                else Navigator.of(context, rootNavigator: true).pop(0);
              },
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            CloseButton(
              color: Colors.white,
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(0),
            ),
          ],
        ),
        backgroundColor: Colors.black26,
        content: Image.file(photo,height: size.height*0.8,width: size.width*0.8),
      );
    },
  );
}

class HelpCarousel extends StatefulWidget {

  final itemList;
  HelpCarousel(this.itemList);

  @override
  _HelpCarouselState createState() => _HelpCarouselState();
}

class _HelpCarouselState extends State<HelpCarousel> {

  CarouselController buttonCarouselController = CarouselController();

  int _current = 0;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
        height: size.height*0.6,
        width: size.width*0.8,
        child: Column(
          children: [
            CarouselSlider(
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                  aspectRatio: 1.0,
                  viewportFraction: 0.9,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }
              ),
              items: widget.itemList.map<Widget>((item) => Container(
                child: Column(
                  children: [
                    Text(
                      item[0],
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 20.0,),
                    Image.asset(item[1], fit: BoxFit.cover),
                  ],
                ),
              )).toList(),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _current != 0 ? RaisedButton(
                  onPressed: () => buttonCarouselController.previousPage(
                      duration: Duration(milliseconds: 300), curve: Curves.linear),
                  child: Text('<- Previous'),
                ) : SizedBox(height:0),
                _current != widget.itemList.length - 1 ? RaisedButton(
                  onPressed: () => buttonCarouselController.nextPage(
                      duration: Duration(milliseconds: 300), curve: Curves.linear),
                  child: Text('Next ->'),
                ):SizedBox(height:0),
              ],
            )
          ],
        )
    );
  }
}

showCarouselDialog(BuildContext context, List<List<String>> itemList) {

  showDialog(
    context: context,
    builder: (context) {
      bool target = true;
      return StatefulBuilder(
        builder: (context, setState) {
          Size size = MediaQuery.of(context).size;
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Help",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                CloseButton(
                  color: Colors.white,
                  onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                ),
              ],
            ),
            backgroundColor: Colors.black26,
            content: Container(
              height: size.height*0.7,
              width: size.width*0.8,
              child: Column(
                children: [
                  target ? Column(
                    children: [
                      Text(
                        "Target Image",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 20.0,),
                      Image.asset(itemList[itemList.length-1][1], fit: BoxFit.cover),
                      SizedBox(height: 20.0,),
                    ],
                  ) : HelpCarousel(itemList),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FlatButton(
                        onPressed: (){
                          setState((){
                            target = false;
                          });
                        },
                        child: Text("Show Steps"),
                        color: target ? Colors.white : Colors.green,
                      ),
                      FlatButton(
                        onPressed: (){
                          setState((){
                            target = true;
                          });
                        },
                        child: Text("Target"),
                        color: target ? Colors.green : Colors.white,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
      );
    },
  );
}