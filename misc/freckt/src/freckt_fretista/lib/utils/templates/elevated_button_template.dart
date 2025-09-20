import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freckt_fretista/utils/consts.dart';

class ElevatedButtonTemplate extends Container {
  ElevatedButtonTemplate({
    @required void Function() onPressed,
    @required String buttonText,
    Color color = Consts.greenDark,
    Color fontColor = Colors.white,
  }) : super(
          margin: EdgeInsets.all(10.0),
          height: 50.0,
          width: 300.0,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              primary: color,
              onPrimary: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
            ),
            child: Text(
              buttonText,
              style: TextStyle(color: fontColor),
            ),
          ),
        );
}
