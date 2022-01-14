import 'package:final_app/app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


mixin ToastUtils {
  void successToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      textColor: AppColors.white,
      backgroundColor: Colors.blue,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void errorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      textColor: AppColors.white,
      backgroundColor: Colors.red,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}