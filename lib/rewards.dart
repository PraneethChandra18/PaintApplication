import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paint_app/Database/databaseHelper.dart';
import 'package:paint_app/utils/global.dart';
import 'package:paint_app/utils/models.dart';


class Rewards extends StatefulWidget {
  @override
  _RewardsState createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {

  DatabaseHelper dbHelper = DatabaseHelper();
  int score = 0;

  Future<void> getTotalScore() async {
    List<UserInformation> userInformation = new List();

    await dbHelper.getUserInformationList().then((userInformationList) {
      userInformation = userInformationList;
    });

    int len = userInformation.length;

    score = 0;
    for(int i=0;i<len;i++) {
      this.score += userInformation[i].score;
    }
  }

  void claimReward(int rewardId) {
    setState(() {
      claimedRewards.add(rewardId);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getTotalScore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rewards"),
        toolbarHeight: 75.0,
        elevation: 10.0,
        backgroundColor: Colors.indigo[900],
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/themebg.jpg"),
            fit: BoxFit.cover,
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20.0,),
            Row(
              children: <Widget>[
                DisplayReward(score, 1, "Shape - Square", 1, claimReward),
                DisplayReward(score, 2, "Shape - Circle", 3, claimReward),
              ],
            ),
            Row(
              children: <Widget>[
                DisplayReward(score, 3, "Random Color Brush", 5, claimReward),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DisplayReward extends StatelessWidget {

  final score;
  final rewardNo;
  final reward;
  final scoreRequired;
  final claimReward;

  DisplayReward(this.score, this.rewardNo, this.reward, this.scoreRequired, this.claimReward);

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width*0.5,
      height: size.height * 0.35,
      child: Column(
        children: <Widget>[
          Card(
            elevation: 10.0,
            color: Colors.white,
            child: Column(
              children: [
                FaIcon(
                  reward == "Shape - Square" ? FontAwesomeIcons.square : (reward == "Shape - Circle" ? FontAwesomeIcons.circle : Icons.brush),
                  size: 80,
                ),
                SizedBox(height: 20),
                SizedBox(width: size.width*0.4),
                Text(
                  reward,
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
                SizedBox(height: 20),
                score < scoreRequired ? FlatButton(onPressed: () => claimReward(rewardNo), child: Text("LOCKED"), color: Colors.grey) : (isClaimed(rewardNo) ? FlatButton(onPressed: () => claimReward(rewardNo), child: Text("CLAIMED"), color: Colors.orange): FlatButton(onPressed: () => claimReward(rewardNo), child: Text("CLAIM"), color: Colors.green,)),
                SizedBox(height: 20),
              ],
            )
          ),
        ],
      ),
    );
  }
}
