import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonTemplate extends Container {
  ButtonTemplate({
    @required void Function() onPressed,
    @required String buttonText,
    Color color = Colors.black,
    Color fontColor = Colors.white,
  }) : super(
          margin: EdgeInsets.all(10.0),
          height: 50.0,
          width: 300.0,
          child: RaisedButton(
            onPressed: onPressed,
            color: color,
            child: Text(
              buttonText,
              style: TextStyle(color: fontColor),
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(40.0),
            ),
          ),
        );
}
