import 'package:flutter/material.dart';
class FilledButton extends StatelessWidget{
  String text;
  Color splashColor;
  Color highlightColor;
  Color fillColor;
  Color textColor;
  Function myFunc;
  FilledButton(String text, Color splashColor, Color highlightColor,
      Color fillColor, Color textColor, void function()){
    this.text = text;
    this.splashColor = splashColor;
    this.highlightColor = highlightColor;
    this.fillColor = fillColor;
    this.textColor = textColor;
    this.myFunc = function;


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      highlightElevation: 0.0,
      splashColor: splashColor,
      highlightColor: highlightColor,
      elevation: 0.0,
      color: fillColor,
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: textColor, fontSize: 20),
      ),
      onPressed: () {
        myFunc();
      },
    );
  }
}