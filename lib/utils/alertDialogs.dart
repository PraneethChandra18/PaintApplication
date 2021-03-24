import 'package:flutter/material.dart';

Future<dynamic> confirmationDialog (BuildContext context, String confirmationFor) async {
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

Future<dynamic> saveExistedDialog (BuildContext context) {
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

Future<dynamic> exitDialog (BuildContext context) {
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