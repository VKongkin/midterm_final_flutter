import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void showCustomToast({
  required String message,
  Color backgroundColor = Colors.green,
  Color textColor = Colors.white,
  ToastGravity gravity = ToastGravity.BOTTOM,
  int toastDuration = 2,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: gravity,
    timeInSecForIosWeb: toastDuration,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: 16.0,
  );
}
