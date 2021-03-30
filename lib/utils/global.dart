import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

List<int> claimedRewards = new List();

bool isClaimed(int rId) {
  var claimed = claimedRewards.firstWhere((rewardId) => rewardId == rId, orElse: () => null);

  if (claimed == null) return false;
  return true;
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