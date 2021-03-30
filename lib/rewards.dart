import 'package:flutter/material.dart';
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
      body: Container(
        child: Column(
          children: [
            Row(
              children: <Widget>[
                DisplayReward(score, 1, "Square Shape", 1, claimReward),
                DisplayReward(score, 2, "Circle Shape", 3, claimReward),
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
    print(score);
    return Container(
      width: size.width*0.5,
      height: size.height * 0.4,
      child: Column(
        children: <Widget>[
          Text(
            reward,
          ),
          score < scoreRequired ? FlatButton(onPressed: () => claimReward(rewardNo), child: Text("LOCKED"), color: Colors.grey) : (isClaimed(rewardNo) ? FlatButton(onPressed: () => claimReward(rewardNo), child: Text("CLAIMED"), color: Colors.orange): FlatButton(onPressed: () => claimReward(rewardNo), child: Text("CLAIM"), color: Colors.green,)),
        ],
      ),
    );
  }
}
