import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paint_app/utils/supportingWidgets.dart';

class MyGallery extends StatefulWidget {
  @override
  _MyGalleryState createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {

  List<FileSystemEntity> allImages = [];

  var _directory;

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

  @override
  void initState() {
    super.initState();
    getAllFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  }
}
