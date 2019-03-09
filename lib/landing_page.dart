import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    var textStyle = new TextStyle(fontSize: 32.0, color: Colors.white);
    return new Material(
      color: Colors.green,
      child: new InkWell(
        onTap: () => print("The page has been tapped"),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Welcome yet another Calculator", style: Theme.of(context).textTheme.headline),
            new Text("This is the second row in my column", style: Theme.of(context).textTheme.subhead)
          ],
        ),
      ),);
  }
}