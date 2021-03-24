import 'package:flutter/material.dart';
import 'package:paint_app/feedback.dart';
import 'package:paint_app/gameMode.dart';
import 'package:paint_app/myGallery.dart';
import 'package:paint_app/practice.dart';
import 'package:paint_app/rewards.dart';
import 'package:paint_app/tutorial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            HomeButtons("Game mode"),
            HomeButtons("Practice"),
            HomeButtons("My Gallery"),
            HomeButtons("Rewards"),
            HomeButtons("Tutorial"),
            HomeButtons("Feedback"),
            SizedBox(height: size.height*0.1)
          ],
        ),
      ),
    );
  }
}

class HomeButtons extends StatelessWidget {

  final name;
  HomeButtons(this.name);

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        Container(
          width: size.width * 0.5,
          child: OutlineButton(
            onPressed: (){
              if(name == "Game mode") Navigator.push(context, MaterialPageRoute(builder: (context) => GameMode()));
              else if(name == "Practice") Navigator.push(context, MaterialPageRoute(builder: (context) => Practice()));
              else if(name == "My Gallery") Navigator.push(context, MaterialPageRoute(builder: (context) => MyGallery()));
              else if(name == "Rewards") Navigator.push(context, MaterialPageRoute(builder: (context) => Rewards()));
              else if(name == "Tutorial") Navigator.push(context, MaterialPageRoute(builder: (context) => Tutorial()));
              else if(name == "Feedback") Navigator.push(context, MaterialPageRoute(builder: (context) => UserFeedback()));
            },
            child: Text(
              name,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            shape: StadiumBorder(),
            borderSide: BorderSide(
              color: Colors.green,
              width: 2.0,
              style: BorderStyle.solid,
            ),
            highlightColor: Colors.green,
            highlightedBorderColor: Colors.green,
          ),
        ),
        SizedBox(height: size.height*0.02),
      ],
    );
  }
}
