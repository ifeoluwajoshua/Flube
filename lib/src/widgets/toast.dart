import 'package:flube/src/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String message){
  return  Fluttertoast.showToast(
        msg: "This is Colored Toast with android duration of 5 Sec",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: shadowColor,
        textColor: Colors.white);
}