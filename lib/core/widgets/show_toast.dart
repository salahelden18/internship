import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String msg, Color bgColor) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: bgColor,
    gravity: ToastGravity.BOTTOM,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
    fontSize: 16,
  );
}
