import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserFeedback extends StatefulWidget {
  @override
  _UserFeedbackState createState() => _UserFeedbackState();
}

class _UserFeedbackState extends State<UserFeedback> {

  double rating = 5.0;
  String remarks;

  void updateRating(double val) {
    setState(() {
      rating = val;
    });
  }

  void updateRemarks(String val) {
    setState(() {
      remarks = val;
    });
  }

  void showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.green,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Rating(rating,updateRating),
            SizedBox(height: 20.0),
            Remarks(updateRemarks),
            SizedBox(height: 20.0),
            FlatButton(
              onPressed: () {
                showToastMessage("Thanks for submitting feedback");
                Navigator.pop(context);
              },
              child: Text(
                "Submit",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

class Rating extends StatefulWidget {

  final rating;
  final updateRating;
  Rating(this.rating,this.updateRating);

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "Rating",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 30.0),
          Slider(
              label: widget.rating == 1 ? "Sad" : ((widget.rating == 2) ? "Below Average" : (widget.rating == 3 ? "Average" : widget.rating == 4 ? "Above Average" : "Happy")),
              value: widget.rating,
              max: 5.0,
              min: 1.0,
              divisions: 4,
              onChanged: (val) => widget.updateRating(val),
              activeColor: Colors.green,
              inactiveColor: Colors.amber,
          ),
        ],
      ),
    );
  }
}

class Remarks extends StatefulWidget {

  final updateRemarks;
  Remarks(this.updateRemarks);

  @override
  _RemarksState createState() => _RemarksState();
}

class _RemarksState extends State<Remarks> {

  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Remarks",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              width: size.width * 0.85,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: "Remarks",
                  hintText: "Write Feedback",
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.redAccent)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.blueAccent)
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.redAccent)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey.shade400)
                  )
                ),
                maxLines: 10,
                onChanged: (val) => widget.updateRemarks(val),
              ),
            ),
          ],
        )
      ),
    );
  }
}

// title.text.toString()