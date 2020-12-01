import 'dart:ui';

import 'package:flutter/material.dart';

typedef CallbackSetting = void Function(String, int);
class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final VoidCallback onPressed;


  // this @required annotation is used because we are using named parameters here. 
 //The purpose of using named parameters is that when you call the function and pass values, you also specify the name of the parameter you are setting. 
 //Forexample, when creating an instance of ProductivityButton , you can use the syntax ProductivityButton ( color: Colors.blueAccent , text: 'Hello
 // World' , onPressed: doSomething , size: 150 ). As named parameters are
 //referenced by name, they can be used in any order.
 
  ProductivityButton ({ @required this.color, @required this.text, @required this.onPressed, @required this.size});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white)
      ),
      onPressed: this.onPressed,
      color: this.color,
      minWidth: this.size,
    );
  }
}


class SettingsButton extends StatelessWidget {
  final Color color;
  final String text;
  final int value;
  final String setting;
  final CallbackSetting callback;
  SettingsButton(this.color, this.text, this.value, this.setting, this.callback);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(this.text, style: TextStyle(color: Colors.white)),
      onPressed: () => this.callback(this.setting, this.value),
      color: this.color,
    );
  }
}