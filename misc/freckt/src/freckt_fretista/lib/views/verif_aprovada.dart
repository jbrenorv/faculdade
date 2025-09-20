import 'package:flutter/material.dart';
import 'package:freckt_fretista/utils/templates/elevated_button_template.dart';
import 'package:freckt_fretista/views/verify_email.dart';
import 'package:freckt_fretista/utils/consts.dart';

class VerifAprovada extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              // mudar para o icone verified_rounded
              child: Icon(Icons.verified_rounded, color: Consts.greenDark, size: 100,),
            ),
            Text(
              'Verificação de\n Documentos Aprovada',
              style: TextStyle(
                color: Colors.black,
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
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => VerifyEmailScreen()),
            (route) => false,
          );
        },
        buttonText: 'Continuar',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
