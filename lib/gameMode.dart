import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bghome.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: size.height * 0.15),
                Center(
                  child: Container(
                    child: Text(
                      "Choose a Drawing",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.indigo[900],
                        fontWeight: FontWeight.bold
                      ),
                    )
                  )
                ),
                LevelButtons("Level 1"),
                LevelButtons("Level 2"),
                LevelButtons("Level 3"),
              ],
            ),
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

    return GestureDetector(
      onTap: (){
        if(name == "Level 1") Navigator.push(context, MaterialPageRoute(builder: (context) => Level1()));
        else if(name == "Level 2") Navigator.push(context, MaterialPageRoute(builder: (context) => Level2()));
        else if(name == "Level 3") Navigator.push(context, MaterialPageRoute(builder: (context) => Level3()));
      },
      child: Center(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              height: size.height*0.5,
              width: size.width*0.6,
              child: Card(
                child: name == "Level 1" ? Image.asset("assets/level1/level1.jpg") : (name == "Level 2" ? Image.asset("assets/level2/level2_6.jpg") : Image.asset("assets/level3/level3.png")),
              ),
            ),
            Positioned(
              bottom: 10,
              left: size.width*0.20,
              child: RaisedButton(
                onPressed: () {},
                shape: CircleBorder(),
                child: Text(
                    name.substring(6),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),
                ),
                color: Colors.indigo[900],
                splashColor: Colors.white,
              ),
            ),
            Positioned(
              bottom: 20,
              left: size.width*0.35,
              child: FlatButton(
                onPressed: () {},
                child: Row(
                  children: <Widget>[
                    Icon(
                      name == "Level 1" ? Icons.star : Icons.star_border,
                      color: name == "Level 1" ? Colors.amber[700] : Colors.black,
                    ),
                    Icon(
                      Icons.star_border,
                      color: Colors.black,
                    ),
                    Icon(
                      Icons.star_border,
                      color: Colors.black,
                    ),
                  ],
                ),
                color: Colors.transparent,
                splashColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
