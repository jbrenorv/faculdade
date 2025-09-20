import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:freckt_fretista/utils/templates/submenu_scaffold_template.dart';

class Fretes extends StatelessWidget {
  static const String _title = 'Fretes realizados';

  @override
  Widget build(BuildContext context) {
    return SubmenuScaffoldTemplate(
      title: _title,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Você não possui nenhum frete já realizado\n:(',
              ),

              /*Text(
                'Você não possui nenhum frete já realizado\n:(',
                style: TextStyle(
                  //color: Colors.black,
                  fontSize: 30.0,
                  //backgroundColor: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),*/
            ),
          ],
        ),
      ),
    );
  }
}
