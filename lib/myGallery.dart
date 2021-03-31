import 'dart:io';

import 'package:flutter/material.dart';
import 'package:paint_app/utils/global.dart';
import 'package:paint_app/utils/supportingWidgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/rendering.dart';
import 'package:paint_app/utils/Grid.dart';
import 'package:share_extend/share_extend.dart';

bool longPress = false;

class MyGallery extends StatefulWidget {
  @override
  _MyGalleryState createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {

  List<FileSystemEntity> allImages = [];
  List<FileSystemEntity> selectedList =[];
  var _directory;
  bool button1, button2;

  void getAllFiles() async
  {
    _directory = await getExternalStorageDirectory();
//    Directory('${_directory.path}/data').delete(recursive: true);
//    File('${_directory.path}/counter/counter.txt').delete(recursive: true);

    await Directory('${_directory.path}').create(recursive: true);

    Directory('${_directory.path}').list(recursive: true, followLinks: false)
        .listen((FileSystemEntity entity) {
      setState(() {
        allImages.add(entity);
      });
    });
  }

  _shareMultipleImages() async {
    var imageList = List<String>();
    for (int i=0;i<selectedList.length;i++) {
      String path =selectedList[i].toString().substring(7);
      path = path.substring(0, path.length - 1);
      imageList.add(path);
    }
    ShareExtend.shareMultiple(imageList, "image",subject: "Share Images");
  }

  Future <void> deleteImage(File file) async {

    if(await file.exists()){
      await file.delete();
    }
  }

  changeAllImages(List<FileSystemEntity> list){
   setState(() {
     allImages = list;
   });
  }

  @override
  void initState() {
    button1 = false;
    button2 = false;
    super.initState();
    getAllFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      appBar: AppBar(
        toolbarHeight: 75.0,
        elevation: 0.0,
        backgroundColor: !longPress ? Colors.transparent : Colors.green,
        title: Text(!longPress ? " " : "${selectedList.length} item(s) selected"),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: <Widget>[
          !longPress
              ? Container()
              : InkWell(

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    selectedList.clear();
                    longPress = false;
                  });
                },
                child: Text("Deselect All"),
              ),
            ),
          ),
          SizedBox(width: 20.0),
          selectedList.length < 1
              ? Container()
              : InkWell(
            onTap: _shareMultipleImages,

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.share),
            ),
          ),
          SizedBox(width: 20.0),
          selectedList.length < 1
              ? Container()
              : InkWell(
            onTap: () async {
              bool result = await confirmationDialog(context, "Delete");
              if(result == true)
              {
                showToastMessage("Deleted!");
                setState(() {
                  for(int i=0;i<selectedList.length;i++){
                    allImages.remove(selectedList[i]);
                    deleteImage(selectedList[i]);
                  }
                  selectedList= [];
                });
              }
            },

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.delete),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        itemCount:allImages.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ,childAspectRatio: 0.56 ,crossAxisSpacing: 2,mainAxisSpacing: 2),
        padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
        scrollDirection: Axis.vertical,
        //reverse: false,
        itemBuilder: (context,index) {
          bool val;
          var selected = selectedList.firstWhere((f) => f == allImages[index], orElse: () => null);

          if (selected == null) val = false;
          else val = true;

          return Card(
            elevation: 20.0,
            shadowColor: Colors.black,
            child: GridItem(
              item:allImages[index],
              isSelected: (bool value){
                setState(() {
                  if(value){
                    selectedList.add(allImages[index]);
                  } else{
                    selectedList.remove(allImages[index]);
                  }
                });
              },
              key: Key(allImages[index].toString()),
              selectedValue: val,
              allImages: allImages,
              changeAllImages: changeAllImages,
            ),
          );
        },
      ),
    );
  }
}

/*

 */
/*
Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
        scrollDirection: Axis.vertical,
        reverse: false,
        itemCount: allImages.length,
        itemBuilder: (context,index) {
          return Card(
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8,20,8,25),
              child: ListTile(
                onTap: () => showPhotoDialog(context, allImages[index]),
                title: Text(basename(allImages[index].toString())),
                leading: Image.file(allImages[index],height: 60,width: 40),
                // trailing: IconButton(
                //   icon: Icon(Icons.delete,color: Colors.red),
                //   onPressed: (){
                //     deleteItem(file);
                //   },
                // ),
              ),
            ),
          );
        },
      ),
    );
 */