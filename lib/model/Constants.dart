import 'package:flutter/material.dart';

class Constants {
  static const product ="product";
  static const category ="category";
  static const riverpoduser ="riverpoduser";
}

void showMessage(BuildContext context,{required String text,required Color color}){
  ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
          backgroundColor: color,
          content: Text(text))
  );
}