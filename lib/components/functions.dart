import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

kShowToast({required String message, int length = 1}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: length == 1 ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey,
    textColor: Colors.black,
    fontSize: 16.0,
  );
}
