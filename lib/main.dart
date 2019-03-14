import 'package:flutter/material.dart';
import 'calculator.dart';

void main(){
  runApp(new MaterialApp(
    title: "Calculator",
    theme: ThemeData(
      primaryColor: Colors.lightBlue[600],
      accentColor: Colors.grey[800],
      highlightColor: Colors.lightBlue[300],
      fontFamily: 'Montserrat',
      textTheme: TextTheme(
        body1: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
      )
    ),
    home: new Calculator()
  ));
}