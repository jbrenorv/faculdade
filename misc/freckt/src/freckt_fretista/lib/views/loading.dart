import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freckt_fretista/utils/consts.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Consts.greenDark),
        ),
      ),
    );
  }
}
