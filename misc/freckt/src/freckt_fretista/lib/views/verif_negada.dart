import 'package:flutter/material.dart';
import 'package:freckt_fretista/utils/templates/elevated_button_template.dart';
import 'package:freckt_fretista/utils/consts.dart';


class VerifNegada extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/negado.png",
              fit: BoxFit.fitHeight,
              height: 100.0,
            ),
            Text(
              'Verificação de\n Documentos Negada',
              style: TextStyle(
                color: Consts.greenDark,
                fontSize: 40.0,
                backgroundColor: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButtonTemplate(
        onPressed: () {
          Navigator.pop(context);
        },
        buttonText: 'Voltar',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
