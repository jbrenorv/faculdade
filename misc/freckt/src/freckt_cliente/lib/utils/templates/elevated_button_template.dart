import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../consts.dart';

class ElevatedButtonTemplate extends Container {
  ElevatedButtonTemplate({
    @required void Function() onPressed,
    @required String buttonText,
    Color color = Colors.black,
    Color fontColor = Colors.white,
  }) : super(
          margin: EdgeInsets.all(10.0),
          height: 50.0,
          width: 300.0,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              primary: Consts.greenDark,
              onPrimary: Consts.greenDark,
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