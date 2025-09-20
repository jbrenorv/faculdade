import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xff13786C)),
        ),
      ),
    );
  }
}
