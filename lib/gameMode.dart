import 'package:flutter/material.dart';
import 'package:paint_app/GameMode/dart/level1.dart';
import 'package:paint_app/GameMode/dart/level2.dart';
import 'package:paint_app/GameMode/dart/level3.dart';

class GameMode extends StatefulWidget {
  @override
  _GameModeState createState() => _GameModeState();
}

class _GameModeState extends State<GameMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              LevelButtons("Level 1"),
              LevelButtons("Level 2"),
              LevelButtons("Level 3"),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: Icon(Icons.exit_to_app),
      ),
    );
  }
}

class LevelButtons extends StatelessWidget {

  final name;
  LevelButtons(this.name);

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        Container(
          width: size.width * 0.5,
          child: OutlineButton(
            onPressed: (){
              if(name == "Level 1") Navigator.push(context, MaterialPageRoute(builder: (context) => Level1()));
              else if(name == "Level 2") Navigator.push(context, MaterialPageRoute(builder: (context) => Level2()));
              else if(name == "Level 3") Navigator.push(context, MaterialPageRoute(builder: (context) => Level3()));
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
