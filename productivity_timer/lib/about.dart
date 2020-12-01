import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 24);
    return Scaffold(
      appBar: AppBar(title: Text('About Us'),),
      body: Container(
        child: Text("Hello, I am godfatherNINZA. This is a time management app. you can join me at (godfatherninza@gmail.com).",
        style: textStyle,),),      
    );
  }
}