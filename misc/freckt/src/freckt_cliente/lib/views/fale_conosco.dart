import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:freckt_cliente/utils/templates/elevated_button_template.dart';

class FaleConosco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff20B8A6),
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Fale Conosco',
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Descreva o problema...',
                border: OutlineInputBorder(),
                fillColor: Colors.grey[250],
                filled: true,
              ),
              keyboardType: TextInputType.text,
              maxLines: 15,
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButtonTemplate(
        onPressed: () {
          showAlertDialog1(context);
        },
        buttonText: ('Avançar'),
        color: Colors.black,
        fontColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

showAlertDialog1(BuildContext context) {
  // configura o button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text("Seu problema foi enviado."),
    content: Text("Iremos solucionar seu problema o mais rápido possível."),
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}
